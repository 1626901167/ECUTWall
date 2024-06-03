package com.wwey.service;

import com.wwey.pojo.Category;

import java.util.List;

public interface CategoryService {

    //新增分类
    void add(Category category);

    //列表查询
    List<Category> list();

    //根据id查询分类信息
    Category findById(Integer id);

    //更新分类
    void update(Category category);

    //根据id删除
    void deleteById(Integer id);
}
