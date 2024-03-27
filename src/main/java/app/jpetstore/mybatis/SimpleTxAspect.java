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
package app.jpetstore.mybatis;

import com.aspectran.core.component.bean.annotation.After;
import com.aspectran.core.component.bean.annotation.Aspect;
import com.aspectran.core.component.bean.annotation.Autowired;
import com.aspectran.core.component.bean.annotation.Bean;
import com.aspectran.core.component.bean.annotation.Before;
import com.aspectran.core.component.bean.annotation.Component;
import com.aspectran.core.component.bean.annotation.Finally;
import com.aspectran.core.component.bean.annotation.Joinpoint;
import com.aspectran.core.component.bean.annotation.Scope;
import com.aspectran.core.context.rule.type.ScopeType;
import com.aspectran.mybatis.SqlSessionTxAdvice;
import org.apache.ibatis.session.SqlSessionFactory;

/**
 * Advice to handle database transactions in simple mode.
 * <ul>
 * <li>A transaction scope will be started (i.e. NOT auto-commit).
 * <li>A Connection object will be acquired from the DataSource instance
 *     configured by the active environment.
 * <li>The transaction isolation level will be the default used by the driver or
 *     data source.
 * <li>No PreparedStatements will be reused, and no updates will be batched.
 * </ul>
 */
@Component
@Bean
@Scope(ScopeType.PROTOTYPE)
@Aspect(
        id = "simpleTxAspect",
        order = 0
)
@Joinpoint(
        pointcut = {
                "+: **@simpleSqlSession"
        }
)
public class SimpleTxAspect extends SqlSessionTxAdvice {

    @Autowired
    public SimpleTxAspect(SqlSessionFactory sqlSessionFactory) {
        super(sqlSessionFactory);
    }

    @Before
    public void open() {
        super.open();
    }

    @After
    public void commit() {
        super.commit();
    }

    @Finally
    public void close() {
        super.close();
    }

}
