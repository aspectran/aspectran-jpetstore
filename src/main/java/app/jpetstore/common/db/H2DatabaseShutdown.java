/*
 * Copyright (c) 2018-2025 The Aspectran Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package app.jpetstore.common.db;

import com.aspectran.core.activity.InstantActivity;
import com.aspectran.core.activity.InstantActivityException;
import com.aspectran.core.component.bean.annotation.AvoidAdvice;
import com.aspectran.core.component.bean.annotation.Bean;
import com.aspectran.core.component.bean.annotation.Component;
import com.aspectran.core.component.bean.annotation.Destroy;
import com.aspectran.core.component.bean.aware.ActivityContextAware;
import com.aspectran.core.context.ActivityContext;
import com.aspectran.utils.annotation.jsr305.NonNull;

import java.sql.Statement;

/**
 * Shutdown H2 database programmatically.
 * <p>Created: 2025. 2. 15.</p>
 */
@Component
@Bean(lazyDestroy = true)
public class H2DatabaseShutdown implements ActivityContextAware {

    private ActivityContext context;

    @Override
    @AvoidAdvice
    public void setActivityContext(@NonNull ActivityContext context) {
        this.context = context;
    }

    @Destroy(profile = "h2")
    public void shutdown() {
        try {
            InstantActivity activity = new InstantActivity(context);
            activity.perform(() -> {
                SimpleSqlSession sqlSession = activity.getBean(SimpleSqlSession.class);
                try (Statement statement = sqlSession.getConnection().createStatement()) {
                    statement.execute("SHUTDOWN");
                }
                return null;
            });
        } catch (Exception e) {
            throw new InstantActivityException(e);
        }
    }

}
