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

import app.jpetstore.catalog.domain.Category;
import com.aspectran.core.component.bean.annotation.Autowired;
import com.aspectran.core.component.bean.annotation.Component;
import com.aspectran.mybatis.SqlMapperAccess;
import com.aspectran.mybatis.SqlMapperProvider;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * The Interface CategoryMapper.
 *
 * @author Juho Jeong
 */
@Mapper
public interface CategoryMapper {

    List<Category> getCategoryList();

    Category getCategory(String categoryId);

    @Component
    class Dao extends SqlMapperAccess<CategoryMapper> implements CategoryMapper {

        @Autowired
        public Dao(SqlMapperProvider sqlMapperProvider) {
            super(sqlMapperProvider, CategoryMapper.class);
        }

        @Override
        public List<Category> getCategoryList() {
            return simple().getCategoryList();
        }

        @Override
        public Category getCategory(String categoryId) {
            return simple().getCategory(categoryId);
        }

    }

}
