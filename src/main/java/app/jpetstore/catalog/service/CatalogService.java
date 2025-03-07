/**
 * Copyright 2010-2019 the original author or authors.
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
package app.jpetstore.catalog.service;

import app.jpetstore.catalog.domain.Category;
import app.jpetstore.catalog.domain.Product;
import app.jpetstore.common.db.mapper.CategoryMapper;
import app.jpetstore.common.db.mapper.ItemMapper;
import app.jpetstore.common.db.mapper.ProductMapper;
import app.jpetstore.order.domain.Item;
import com.aspectran.core.component.bean.annotation.Autowired;
import com.aspectran.core.component.bean.annotation.Bean;
import com.aspectran.core.component.bean.annotation.Component;

import java.util.ArrayList;
import java.util.List;

/**
 * The Class CatalogService.
 *
 * @author Juho Jeong
 */
@Component
@Bean("catalogService")
public class CatalogService {

    private final CategoryMapper.Dao categoryDao;
    
    private final ProductMapper.Dao productDao;

    private final ItemMapper.Dao itemDao;

    @Autowired
    public CatalogService(CategoryMapper.Dao categoryDao,
                          ProductMapper.Dao productDao,
                          ItemMapper.Dao itemDao) {
        this.productDao = productDao;
        this.categoryDao = categoryDao;
        this.itemDao = itemDao;
    }

    public List<Category> getCategoryList() {
        return categoryDao.getCategoryList();
    }

    public Category getCategory(String categoryId) {
        return categoryDao.getCategory(categoryId);
    }

    public Product getProduct(String productId) {
        return productDao.getProduct(productId);
    }

    public List<Product> getProductListByCategory(String categoryId) {
        return productDao.getProductListByCategory(categoryId);
    }

    /**
     * Search product list.
     * @param keywords the keywords
     * @return the list
     */
    public List<Product> searchProductList(String keywords) {
        List<Product> products = new ArrayList<>();
        if (keywords != null) {
            for (String keyword : keywords.split("\\s+")) {
                products.addAll(productDao.searchProductList("%" + keyword.toLowerCase() + "%"));
            }
        }
        return products;
    }

    public List<Item> getItemListByProduct(String productId) {
        return itemDao.getItemListByProduct(productId);
    }

    public Item getItem(String itemId) {
        return itemDao.getItem(itemId);
    }

    public boolean isItemInStock(String itemId) {
        return (itemDao.getInventoryQuantity(itemId) > 0);
    }

}
