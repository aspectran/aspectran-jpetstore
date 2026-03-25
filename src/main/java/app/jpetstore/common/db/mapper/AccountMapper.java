/*
 * Copyright 2010-2017 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package app.jpetstore.common.db.mapper;

import app.jpetstore.account.domain.Account;
import com.aspectran.core.component.bean.annotation.Autowired;
import com.aspectran.core.component.bean.annotation.Component;
import com.aspectran.mybatis.SqlMapperAccess;
import com.aspectran.mybatis.SqlMapperProvider;
import org.apache.ibatis.annotations.Mapper;

/**
 * The Interface AccountMapper.
 *
 * @author Juho Jeong
 */
@Mapper
public interface AccountMapper {

    Account getAccountByUsername(String username);

    Account getAccountByUsernameAndPassword(String username, String password);

    void insertAccount(Account account);

    void insertProfile(Account account);

    void insertSignon(Account account);

    void updateAccount(Account account);

    void updateProfile(Account account);

    void updateSignon(Account account);

    @Component
    class Dao extends SqlMapperAccess<AccountMapper> implements AccountMapper {

        @Autowired
        public Dao(SqlMapperProvider sqlMapperProvider) {
            super(sqlMapperProvider);
        }

        @Override
        public Account getAccountByUsername(String username) {
            return mapper().getAccountByUsername(username);
        }

        @Override
        public Account getAccountByUsernameAndPassword(String username, String password) {
            return mapper().getAccountByUsernameAndPassword(username, password);
        }

        @Override
        public void insertAccount(Account account) {
            mapper().insertAccount(account);
        }

        @Override
        public void insertProfile(Account account) {
            mapper().insertProfile(account);
        }

        @Override
        public void insertSignon(Account account) {
            mapper().insertSignon(account);
        }

        @Override
        public void updateAccount(Account account) {
            mapper().updateAccount(account);
        }

        @Override
        public void updateProfile(Account account) {
            mapper().updateProfile(account);
        }

        @Override
        public void updateSignon(Account account) {
            mapper().updateSignon(account);
        }

    }

}
