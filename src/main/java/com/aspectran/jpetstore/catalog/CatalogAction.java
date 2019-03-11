/**
 * Copyright 2010-2017 the original author or authors.
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
package com.aspectran.jpetstore.catalog;

import com.aspectran.core.activity.Translet;
import com.aspectran.core.component.bean.annotation.Action;
import com.aspectran.core.component.bean.annotation.Autowired;
import com.aspectran.core.component.bean.annotation.Bean;
import com.aspectran.core.component.bean.annotation.Component;
import com.aspectran.core.component.bean.annotation.Dispatch;
import com.aspectran.core.component.bean.annotation.Redirect;
import com.aspectran.core.component.bean.annotation.Request;
import com.aspectran.core.util.StringUtils;
import com.aspectran.jpetstore.order.domain.Item;
import com.aspectran.jpetstore.catalog.domain.Category;
import com.aspectran.jpetstore.catalog.domain.Product;
import com.aspectran.jpetstore.catalog.service.CatalogService;

import java.util.List;

/**
 * The Class CatalogAction.
 *
 * @author Juho Jeong
 */
@Component
@Bean("catalogAction")
public class CatalogAction {

    private CatalogService catalogService;

    @Autowired
    public CatalogAction(CatalogService catalogService) {
        this.catalogService = catalogService;
    }

    @Request("/")
    @Redirect("/catalog/")
    public void home() {
    }

    @Request("/catalog/")
    @Dispatch("catalog/Main")
    public void viewMain() {
    }

    /**
     * View category.
     */
    @Request("/catalog/categories/${categoryId}")
    @Dispatch("catalog/Category")
    public void viewCategory(Translet translet, String categoryId) {
        if (categoryId != null) {
            Category category = catalogService.getCategory(categoryId);
            List<Product> productList = catalogService.getProductListByCategory(categoryId);
            translet.setAttribute("category", category);
            translet.setAttribute("productList", productList);
        }
    }

    /**
     * View product.
     */
    @Request("/catalog/products/${productId}")
    @Dispatch("catalog/Product")
    public void viewProduct(Translet translet, String productId) {
        if (productId != null) {
            Product product = catalogService.getProduct(productId);
            List<Item> itemList = catalogService.getItemListByProduct(productId);
            translet.setAttribute("product", product);
            translet.setAttribute("itemList", itemList);
        }
    }

    /**
     * View item.
     */
    @Request("/catalog/items/${itemId}")
    @Dispatch("catalog/Item")
    public void viewItem(Translet translet, String itemId) {
        Item item = catalogService.getItem(itemId);
        if (item != null) {
            Product product = item.getProduct();
            translet.setAttribute("item", item);
            translet.setAttribute("product", product);
        }
    }

    /**
     * Search products.
     */
    @Request("/catalog/searchProducts")
    @Dispatch("catalog/SearchProducts")
    @Action("productList")
    public List<Product> searchProducts(String keyword) {
        if (!StringUtils.isEmpty(keyword)) {
            return catalogService.searchProductList(keyword.toLowerCase());
        } else {
            return null;
        }
    }

}
