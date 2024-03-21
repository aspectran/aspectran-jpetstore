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
import com.aspectran.jpetstore.catalog.domain.Product;
import com.aspectran.jpetstore.common.mybatis.SqlMapperAgent;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * The Interface ProductMapper.
 *
 * @author Juho Jeong
 */
@Mapper
public interface ProductMapper {

    List<Product> getProductListByCategory(String categoryId);

    Product getProduct(String productId);

    List<Product> searchProductList(String keywords);

    @Component
    class Dao implements ProductMapper {

        private final SqlMapperAgent mapperAgent;

        @Autowired
        public Dao(SqlMapperAgent mapperAgent) {
            this.mapperAgent = mapperAgent;
        }

        @Override
        public List<Product> getProductListByCategory(String categoryId) {
            return mapperAgent.simple(ProductMapper.class).getProductListByCategory(categoryId);
        }

        @Override
        public Product getProduct(String productId) {
            return mapperAgent.simple(ProductMapper.class).getProduct(productId);
        }

        @Override
        public List<Product> searchProductList(String keywords) {
            return mapperAgent.simple(ProductMapper.class).searchProductList(keywords);
        }

    }

}
