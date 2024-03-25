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
import com.aspectran.jpetstore.common.mybatis.AbstractDao;
import com.aspectran.jpetstore.common.mybatis.SqlMapperAgent;
import com.aspectran.jpetstore.order.domain.Sequence;
import org.apache.ibatis.annotations.Mapper;

/**
 * The Interface SequenceMapper.
 *
 * @author Juho Jeong
 */
@Mapper
public interface SequenceMapper {

    Sequence getSequence(Sequence sequence);

    void updateSequence(Sequence sequence);

    @Component
    class Dao extends AbstractDao<SequenceMapper> implements SequenceMapper {

        @Autowired
        public Dao(SqlMapperAgent mapperAgent) {
            super(mapperAgent, SequenceMapper.class);
        }

        @Override
        public Sequence getSequence(Sequence sequence) {
            return simple().getSequence(sequence);
        }

        @Override
        public void updateSequence(Sequence sequence) {
            simple().updateSequence(sequence);
        }

    }

}
