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
import com.aspectran.jpetstore.common.mybatis.SqlMapperAgent;
import com.aspectran.jpetstore.order.domain.Item;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

/**
 * The Interface ItemMapper.
 *
 * @author Juho Jeong
 */
@Mapper
public interface ItemMapper {

    void updateInventoryQuantity(Map<String, Object> param);

    int getInventoryQuantity(String itemId);

    List<Item> getItemListByProduct(String productId);

    Item getItem(String itemId);

    @Component
    class Dao implements ItemMapper {

        private final SqlMapperAgent mapperAgent;

        @Autowired
        public Dao(SqlMapperAgent mapperAgent) {
            this.mapperAgent = mapperAgent;
        }

        @Override
        public void updateInventoryQuantity(Map<String, Object> params) {
            mapperAgent.simple(ItemMapper.class).updateInventoryQuantity(params);
        }

        @Override
        public int getInventoryQuantity(String itemId) {
            return mapperAgent.simple(ItemMapper.class).getInventoryQuantity(itemId);
        }

        @Override
        public List<Item> getItemListByProduct(String productId) {
            return mapperAgent.simple(ItemMapper.class).getItemListByProduct(productId);
        }

        @Override
        public Item getItem(String itemId) {
            return mapperAgent.simple(ItemMapper.class).getItem(itemId);
        }

    }

}
