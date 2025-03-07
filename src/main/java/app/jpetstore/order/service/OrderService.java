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
package app.jpetstore.order.service;

import app.jpetstore.common.db.mapper.ItemMapper;
import app.jpetstore.common.db.mapper.LineItemMapper;
import app.jpetstore.common.db.mapper.OrderMapper;
import app.jpetstore.common.db.mapper.SequenceMapper;
import app.jpetstore.order.domain.Item;
import app.jpetstore.order.domain.Order;
import app.jpetstore.order.domain.Sequence;
import com.aspectran.core.component.bean.annotation.Autowired;
import com.aspectran.core.component.bean.annotation.Bean;
import com.aspectran.core.component.bean.annotation.Component;
import com.aspectran.utils.annotation.jsr305.NonNull;

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

    private final ItemMapper.Dao itemDao;

    private final OrderMapper.Dao orderDao;

    private final LineItemMapper.Dao lineItemDao;

    private final SequenceMapper.Dao sequenceDao;

    @Autowired
    public OrderService(ItemMapper.Dao itemDao,
                        OrderMapper.Dao orderDao,
                        LineItemMapper.Dao lineItemDao,
                        SequenceMapper.Dao sequenceDao) {
        this.itemDao = itemDao;
        this.orderDao = orderDao;
        this.lineItemDao = lineItemDao;
        this.sequenceDao = sequenceDao;
    }

    /**
     * Insert order.
     * @param order the order
     */
    public void insertOrder(@NonNull Order order) {
        order.setOrderId(getNextId("ordernum"));
        order.getLineItems().forEach(lineItem -> {
            String itemId = lineItem.getItemId();
            Integer increment = lineItem.getQuantity();
            Map<String, Object> params = new HashMap<>();
            params.put("itemId", itemId);
            params.put("increment", increment);
            itemDao.updateInventoryQuantity(params);
        });

        orderDao.insertOrder(order);
        orderDao.insertOrderStatus(order);
        order.getLineItems().forEach(lineItem -> {
            lineItem.setOrderId(order.getOrderId());
            lineItemDao.insertLineItem(lineItem);
        });
    }

    /**
     * Delete order.
     * @param orderId the order id
     */
    public void deleteOrder(int orderId) {
        orderDao.deleteOrder(orderId);
    }

    /**
     * Gets the order.
     * @param orderId the order id
     * @return the order
     */
    public Order getOrder(int orderId) {
        Order order = orderDao.getOrder(orderId);
        if (order != null) {
            order.setLineItems(lineItemDao.getLineItemsByOrderId(orderId));
            order.getLineItems().forEach(lineItem -> {
                Item item = itemDao.getItem(lineItem.getItemId());
                item.setQuantity(itemDao.getInventoryQuantity(lineItem.getItemId()));
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
        return orderDao.getOrdersByUsername(username);
    }

    /**
     * Gets the next id.
     * @param name the name
     * @return the next id
     */
    public int getNextId(String name) {
        Sequence sequence = sequenceDao.getSequence(new Sequence(name, -1));
        if (sequence == null) {
            throw new RuntimeException(
                    "Error: A null sequence was returned from the database (could not get next " + name + " sequence)");
        }
        Sequence parameterObject = new Sequence(name, sequence.getNextId() + 1);
        sequenceDao.updateSequence(parameterObject);
        return sequence.getNextId();
    }

}
