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
package org.mybatis.jpetstore.common.mybatis.mapper;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.jpetstore.order.domain.Order;

import java.util.List;

/**
 * The Interface OrderMapper.
 *
 * @author Juho Jeong
 */
public interface OrderMapper {

    static OrderMapper getMapper(SqlSession sqlSession) {
        return sqlSession.getMapper(OrderMapper.class);
    }

    List<Order> getOrdersByUsername(String username);

    Order getOrder(int orderId);

    void insertOrder(Order order);

    void insertOrderStatus(Order order);

}
