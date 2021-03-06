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
package com.aspectran.jpetstore.order.service;

import com.aspectran.core.component.bean.annotation.Autowired;
import com.aspectran.core.component.bean.annotation.Bean;
import com.aspectran.core.component.bean.annotation.Component;
import com.aspectran.jpetstore.common.mybatis.SimpleSqlSession;
import com.aspectran.jpetstore.common.mybatis.mapper.ItemMapper;
import com.aspectran.jpetstore.common.mybatis.mapper.LineItemMapper;
import com.aspectran.jpetstore.common.mybatis.mapper.OrderMapper;
import com.aspectran.jpetstore.common.mybatis.mapper.SequenceMapper;
import com.aspectran.jpetstore.order.domain.Item;
import com.aspectran.jpetstore.order.domain.Order;
import com.aspectran.jpetstore.order.domain.Sequence;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * The Class OrderService.
 *
 * @author Juho Jeong
 */
@Component
@Bean("orderService")
public class OrderService {

    private final SqlSession sqlSession;

    @Autowired
    public OrderService(SimpleSqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }

    /**
     * Insert order.
     * @param order the order
     */
    public void insertOrder(Order order) {
        ItemMapper itemMapper = ItemMapper.getMapper(sqlSession);
        OrderMapper orderMapper = OrderMapper.getMapper(sqlSession);
        LineItemMapper lineItemMapper = LineItemMapper.getMapper(sqlSession);

        order.setOrderId(getNextId("ordernum"));
        order.getLineItems().forEach(lineItem -> {
            String itemId = lineItem.getItemId();
            Integer increment = lineItem.getQuantity();
            Map<String, Object> params = new HashMap<>();
            params.put("itemId", itemId);
            params.put("increment", increment);
            itemMapper.updateInventoryQuantity(params);
        });

        orderMapper.insertOrder(order);
        orderMapper.insertOrderStatus(order);
        order.getLineItems().forEach(lineItem -> {
            lineItem.setOrderId(order.getOrderId());
            lineItemMapper.insertLineItem(lineItem);
        });
    }

    /**
     * Delete order.
     * @param orderId the order id
     */
    public void deleteOrder(int orderId) {
        OrderMapper orderMapper = OrderMapper.getMapper(sqlSession);
        orderMapper.deleteOrder(orderId);
    }

    /**
     * Gets the order.
     * @param orderId the order id
     * @return the order
     */
    public Order getOrder(int orderId) {
        ItemMapper itemMapper = ItemMapper.getMapper(sqlSession);
        OrderMapper orderMapper = OrderMapper.getMapper(sqlSession);
        LineItemMapper lineItemMapper = LineItemMapper.getMapper(sqlSession);

        Order order = orderMapper.getOrder(orderId);
        if (order != null) {
            order.setLineItems(lineItemMapper.getLineItemsByOrderId(orderId));
            order.getLineItems().forEach(lineItem -> {
                Item item = itemMapper.getItem(lineItem.getItemId());
                item.setQuantity(itemMapper.getInventoryQuantity(lineItem.getItemId()));
                lineItem.setItem(item);
            });
        }
        return order;
    }

    /**
     * Gets the orders by username.
     * @param username the username
     * @return the orders by username
     */
    public List<Order> getOrdersByUsername(String username) {
        return OrderMapper.getMapper(sqlSession).getOrdersByUsername(username);
    }

    /**
     * Gets the next id.
     * @param name the name
     * @return the next id
     */
    public int getNextId(String name) {
        SequenceMapper sequenceMapper = SequenceMapper.getMapper(sqlSession);
        Sequence sequence = sequenceMapper.getSequence(new Sequence(name, -1));
        if (sequence == null) {
            throw new RuntimeException(
                    "Error: A null sequence was returned from the database (could not get next " + name + " sequence)");
        }
        Sequence parameterObject = new Sequence(name, sequence.getNextId() + 1);
        sequenceMapper.updateSequence(parameterObject);
        return sequence.getNextId();
    }

}
