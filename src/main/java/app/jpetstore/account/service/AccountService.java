/**
 * Copyright 2010-2018 the original author or authors.
 * <p>
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * <p>
 * http://www.apache.org/licenses/LICENSE-2.0
 * <p>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package app.jpetstore.account.service;

import app.jpetstore.account.domain.Account;
import app.jpetstore.common.db.mapper.AccountMapper;
import com.aspectran.core.component.bean.annotation.Autowired;
import com.aspectran.core.component.bean.annotation.Bean;
import com.aspectran.core.component.bean.annotation.Component;

import java.util.Optional;

/**
 * The Class AccountService.
 *
 * @author Juho Jeong
 */
@Component
@Bean("accountService")
public class AccountService {

    private final AccountMapper.Dao dao;

    @Autowired
    public AccountService(AccountMapper.Dao dao) {
        this.dao = dao;
    }

    public Account getAccount(String username) {
        return dao.getAccountByUsername(username);
    }

    public Account getAccount(String username, String password) {
        return dao.getAccountByUsernameAndPassword(username, password);
    }

    /**
     * Insert account.
     * @param account the account
     */
    public void insertAccount(Account account) {
        dao.insertAccount(account);
        dao.insertProfile(account);
        dao.insertSignon(account);
    }

    /**
     * Update account.
     * @param account the account
     */
    public void updateAccount(Account account) {
        dao.updateAccount(account);
        dao.updateProfile(account);

        //j2ee user's password cannot be changed in this demo application
        if (!"j2ee".equals(account.getUsername())) {
            Optional.ofNullable(account.getPassword())
                    .filter(password -> !password.isEmpty())
                    .ifPresent(password -> dao.updateSignon(account));
        }
    }

}
