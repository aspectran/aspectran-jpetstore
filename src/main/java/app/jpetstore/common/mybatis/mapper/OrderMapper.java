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
package app.jpetstore.common.mybatis.mapper;

import app.jpetstore.order.domain.Order;
import com.aspectran.core.component.bean.annotation.Autowired;
import com.aspectran.core.component.bean.annotation.Component;
import com.aspectran.mybatis.SqlMapperProvider;
import com.aspectran.mybatis.SqlMapperAccess;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * The Interface OrderMapper.
 *
 * @author Juho Jeong
 */
@Mapper
public interface OrderMapper {

    List<Order> getOrdersByUsername(String username);

    Order getOrder(int orderId);

    void insertOrder(Order order);

    void insertOrderStatus(Order order);

    void deleteOrder(int orderId);

    void deleteOrderStatus(int orderId);

    @Component
    class Dao extends SqlMapperAccess<OrderMapper> implements OrderMapper {

        @Autowired
        public Dao(SqlMapperProvider sqlMapperProvider) {
            super(sqlMapperProvider, OrderMapper.class);
        }

        @Override
        public List<Order> getOrdersByUsername(String username) {
            return simple().getOrdersByUsername(username);
        }

        @Override
        public Order getOrder(int orderId) {
            return simple().getOrder(orderId);
        }

        @Override
        public void insertOrder(Order order) {
            simple().insertOrder(order);
        }

        @Override
        public void insertOrderStatus(Order order) {
            simple().insertOrderStatus(order);
        }

        @Override
        public void deleteOrder(int orderId) {
            simple().deleteOrder(orderId);
        }

        @Override
        public void deleteOrderStatus(int orderId) {
            simple().deleteOrderStatus(orderId);
        }

    }

}
