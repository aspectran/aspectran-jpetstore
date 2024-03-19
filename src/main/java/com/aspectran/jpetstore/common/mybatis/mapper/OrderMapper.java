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

import com.aspectran.jpetstore.order.domain.Order;
import com.aspectran.utils.annotation.jsr305.NonNull;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

/**
 * The Interface OrderMapper.
 *
 * @author Juho Jeong
 */
public interface OrderMapper {

    static OrderMapper getMapper(@NonNull SqlSession sqlSession) {
        return sqlSession.getMapper(OrderMapper.class);
    }

    List<Order> getOrdersByUsername(String username);

    Order getOrder(int orderId);

    void insertOrder(Order order);

    void insertOrderStatus(Order order);

    void deleteOrder(int orderId);

    void deleteOrderStatus(int orderId);

}
