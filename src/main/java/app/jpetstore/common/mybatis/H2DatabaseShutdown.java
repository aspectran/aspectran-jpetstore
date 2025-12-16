/*
 * Copyright (c) 2018-present The Aspectran Project
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
import com.aspectran.core.component.bean.annotation.Bean;
import com.aspectran.core.component.bean.annotation.Component;
import com.aspectran.core.component.bean.annotation.Destroy;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.jspecify.annotations.NonNull;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.Connection;
import java.sql.SQLException;

/**
 * Shutdown H2 database programmatically.
 * <p>Created: 2025. 2. 15.</p>
 */
@Component
@Bean(lazyDestroy = true)
public final class H2DatabaseShutdown {

    private static final Logger logger = LoggerFactory.getLogger(H2DatabaseShutdown.class);

    private final SqlSessionFactory sqlSessionFactory;

    @Autowired(required = false)
    public H2DatabaseShutdown(SqlSessionFactory sqlSessionFactory) {
        this.sqlSessionFactory = sqlSessionFactory;
    }

    @Destroy(profile = "h2")
    public void shutdown() {
        if (sqlSessionFactory != null) {
            try (SqlSession sqlSession = sqlSessionFactory.openSession()) {
                executeShutdown(sqlSession.getConnection());
            } catch (SQLException e) {
                if (!e.getMessage().contains("Database is already closed")) {
                    logger.error("Failed to shutdown H2 database", e);
                }
            }
        }
    }

    public void executeShutdown(@NonNull Connection connection) throws SQLException {
        if (connection.getMetaData().getDatabaseProductName().equals("H2")) {
            logger.info("Shutting down H2 database");
            connection.createStatement().execute("SHUTDOWN");
        } else {
            logger.info("Not shutting down non-H2 database");
        }
    }

}
