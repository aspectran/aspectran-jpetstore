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
package com.aspectran.jpetstore.account;

import com.aspectran.core.activity.Translet;
import com.aspectran.core.component.bean.annotation.Autowired;
import com.aspectran.core.component.bean.annotation.Bean;
import com.aspectran.core.component.bean.annotation.Component;
import com.aspectran.core.component.bean.annotation.Dispatch;
import com.aspectran.core.component.bean.annotation.Redirect;
import com.aspectran.core.component.bean.annotation.Request;
import com.aspectran.core.component.bean.annotation.RequestToPost;
import com.aspectran.core.util.StringUtils;
import com.aspectran.jpetstore.account.domain.Account;
import com.aspectran.jpetstore.account.service.AccountService;
import com.aspectran.jpetstore.catalog.domain.Product;
import com.aspectran.jpetstore.catalog.service.CatalogService;
import com.aspectran.jpetstore.common.user.UserSession;
import com.aspectran.jpetstore.common.user.UserSessionManager;
import com.aspectran.jpetstore.common.validation.BeanValidator;

import java.util.List;

/**
 * The Class AccountAction.
 *
 * @author Juho Jeong
 */
@Component
@Bean("accountAction")
public class AccountAction {

    @Autowired
    public AccountService accountService;

    @Autowired
    public CatalogService catalogService;

    @Autowired
    public UserSessionManager sessionManager;

    @Request("/account/newAccountForm")
    @Dispatch("account/NewAccountForm")
    public void newAccountForm(Translet translet) {
    }

    /**
     * New account.
     */
    @Request("/account/newAccount")
    @Redirect("/account/signonForm?created=true")
    public void newAccount(Translet translet,
                           Account account,
                           BeanValidator beanValidator) {
        beanValidator.validate(translet, account, Account.Create.class);
        if (beanValidator.hasErrors()) {
            translet.setAttribute("account", account);
            translet.setAttribute("errors", beanValidator.getErrors());
            translet.forward("/account/newAccountForm");
            return;
        }

        accountService.insertAccount(account);
    }

    /**
     * Edits the account form.
     */
    @Request("/account/editAccountForm")
    @Dispatch("account/EditAccountForm")
    public void editAccountForm(Translet translet) {
        if (translet.getAttribute("account") == null) {
            translet.setAttribute("account", sessionManager.getUserSession().getAccount());
        } else {
            Account account = translet.getAttribute("account");
            account.setUsername(sessionManager.getUserSession().getAccount().getUsername());
        }
    }

    /**
     * Edits the account.
     */
    @Request("/account/editAccount")
    @Redirect("/account/editAccountForm?updated=true")
    public void editAccount(Translet translet,
                            Account account,
                            BeanValidator beanValidator) {
        beanValidator.validate(translet, account);
        if (beanValidator.hasErrors()) {
            translet.setAttribute("account", account);
            translet.setAttribute("errors", beanValidator.getErrors());
            translet.forward("/account/editAccountForm");
            return;
        }

        String username = sessionManager.getUserSession().getAccount().getUsername();
        account.setUsername(username);
        accountService.updateAccount(account);
        account = accountService.getAccount(account.getUsername());
        List<Product> products = catalogService.getProductListByCategory(account.getFavouriteCategoryId());
        UserSession userSession = sessionManager.getUserSession();
        userSession.setAccount(account);
        userSession.setProducts(products);
    }

    /**
     * Signon form.
     */
    @Request("/account/signonForm")
    @Dispatch("account/SignonForm")
    public void signonForm() {
    }

    /**
     * Signon.
     */
    @RequestToPost("/account/signon")
    @Redirect("/catalog/")
    public void signon(Translet translet,
                       String username,
                       String password,
                       String referer) {
        Account account = accountService.getAccount(username, password);
        if (account == null) {
            translet.redirect("/account/signonForm?retry=true");
        } else {
            account.setPassword(null);
            List<Product> products = catalogService.getProductListByCategory(account.getFavouriteCategoryId());
            UserSession userSession = sessionManager.getUserSession();
            userSession.setAccount(account);
            userSession.setProducts(products);
            userSession.setAuthenticated(true);

            if (StringUtils.hasLength(referer)) {
                translet.redirect(referer);
            }
        }
    }

    /**
     * Signoff.
     */
    @Request("/account/signoff")
    @Redirect("/catalog/")
    public void signoff() {
        sessionManager.expire();
    }

}
