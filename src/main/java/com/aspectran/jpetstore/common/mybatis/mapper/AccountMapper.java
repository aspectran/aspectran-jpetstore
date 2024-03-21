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
import com.aspectran.jpetstore.common.mybatis.SqlMapper;
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
    class Dao implements AccountMapper {

        private final SqlMapper sqlMapper;

        @Autowired
        public Dao(SqlMapper sqlMapper) {
            this.sqlMapper = sqlMapper;
        }

        @Override
        public Account getAccountByUsername(String username) {
            return sqlMapper.simple(AccountMapper.class).getAccountByUsername(username);
        }

        @Override
        public Account getAccountByUsernameAndPassword(String username, String password) {
            return sqlMapper.simple(AccountMapper.class).getAccountByUsernameAndPassword(username, password);
        }

        @Override
        public void insertAccount(Account account) {
            sqlMapper.simple(AccountMapper.class).insertAccount(account);
        }

        @Override
        public void insertProfile(Account account) {
            sqlMapper.simple(AccountMapper.class).insertProfile(account);
        }

        @Override
        public void insertSignon(Account account) {
            sqlMapper.simple(AccountMapper.class).insertSignon(account);
        }

        @Override
        public void updateAccount(Account account) {
            sqlMapper.simple(AccountMapper.class).updateAccount(account);
        }

        @Override
        public void updateProfile(Account account) {
            sqlMapper.simple(AccountMapper.class).updateProfile(account);
        }

        @Override
        public void updateSignon(Account account) {
            sqlMapper.simple(AccountMapper.class).updateSignon(account);
        }

    }

}
