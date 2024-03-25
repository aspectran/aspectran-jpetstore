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
package com.aspectran.jpetstore.common.mybatis.mapper;

import com.aspectran.core.component.bean.annotation.Autowired;
import com.aspectran.core.component.bean.annotation.Component;
import com.aspectran.jpetstore.account.domain.Account;
import com.aspectran.jpetstore.common.mybatis.AbstractDao;
import com.aspectran.jpetstore.common.mybatis.SqlMapperAgent;
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
    class Dao extends AbstractDao<AccountMapper> implements AccountMapper {

        @Autowired
        public Dao(SqlMapperAgent mapperAgent) {
            super(mapperAgent, AccountMapper.class);
        }

        @Override
        public Account getAccountByUsername(String username) {
            return simple().getAccountByUsername(username);
        }

        @Override
        public Account getAccountByUsernameAndPassword(String username, String password) {
            return simple().getAccountByUsernameAndPassword(username, password);
        }

        @Override
        public void insertAccount(Account account) {
            simple().insertAccount(account);
        }

        @Override
        public void insertProfile(Account account) {
            simple().insertProfile(account);
        }

        @Override
        public void insertSignon(Account account) {
            simple().insertSignon(account);
        }

        @Override
        public void updateAccount(Account account) {
            simple().updateAccount(account);
        }

        @Override
        public void updateProfile(Account account) {
            simple().updateProfile(account);
        }

        @Override
        public void updateSignon(Account account) {
            simple().updateSignon(account);
        }

    }

}
