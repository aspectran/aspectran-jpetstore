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

import com.aspectran.jpetstore.order.domain.Sequence;
import com.aspectran.utils.annotation.jsr305.NonNull;
import org.apache.ibatis.session.SqlSession;

/**
 * The Interface SequenceMapper.
 *
 * @author Juho Jeong
 */
public interface SequenceMapper {

    static SequenceMapper getMapper(@NonNull SqlSession sqlSession) {
        return sqlSession.getMapper(SequenceMapper.class);
    }

    Sequence getSequence(Sequence sequence);

    void updateSequence(Sequence sequence);

}
