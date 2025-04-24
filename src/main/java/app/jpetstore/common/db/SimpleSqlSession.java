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

import com.aspectran.core.component.bean.annotation.AvoidAdvice;
import com.aspectran.core.component.bean.annotation.Bean;
import com.aspectran.core.component.bean.annotation.Component;
import com.aspectran.core.component.bean.annotation.Initialize;
import com.aspectran.mybatis.SqlSessionAgent;

@Component
@Bean(id = "simpleSqlSession", lazyDestroy = true, proxied = true)
public class SimpleSqlSession extends SqlSessionAgent {

    public SimpleSqlSession() {
        super("simpleTxAspect");
    }

    @Initialize
    @AvoidAdvice
    public void registerSqlSessionTxAdvice() {
        super.registerSqlSessionTxAdvice();
    }

}
