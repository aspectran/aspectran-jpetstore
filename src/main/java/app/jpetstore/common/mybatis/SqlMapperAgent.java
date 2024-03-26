/*
 * Copyright (c) 2008-2024 The Aspectran Project
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
package app.jpetstore.common.mybatis;

import com.aspectran.core.component.bean.annotation.Autowired;
import com.aspectran.core.component.bean.annotation.Component;
import com.aspectran.utils.annotation.jsr305.NonNull;
import org.apache.ibatis.session.SqlSession;

@Component
public class SqlMapperAgent {

    private final SqlSession simpleSqlSession;

    private final SqlSession batchSqlSession;

    private final SqlSession reuseSqlSession;

    @Autowired
    public SqlMapperAgent(@NonNull SimpleSqlSession simpleSqlSession,
                          @NonNull BatchSqlSession batchSqlSession,
                          @NonNull ReuseSqlSession reuseSqlSession) {
        this.simpleSqlSession = simpleSqlSession;
        this.batchSqlSession = batchSqlSession;
        this.reuseSqlSession = reuseSqlSession;
    }

    public SqlSession getSimpleSqlSession() {
        return simpleSqlSession;
    }

    public SqlSession getBatchSqlSession() {
        return batchSqlSession;
    }

    public SqlSession getReuseSqlSession() {
        return reuseSqlSession;
    }

    public <T> T simple(Class<T> type) {
        return getSimpleSqlSession().getMapper(type);
    }

    public <T> T batch(Class<T> type) {
        return getBatchSqlSession().getMapper(type);
    }

    public <T> T reuse(Class<T> type) {
        return getReuseSqlSession().getMapper(type);
    }

}
