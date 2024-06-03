package com.wwey.controller;

import com.wwey.pojo.Article;
import com.wwey.pojo.PageBean;
import com.wwey.pojo.Result;
import com.wwey.service.ArticleService;
import com.wwey.utils.JwtUtil;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.Map;

@RestController
@RequestMapping("/article")
public class ArticleController {

    @Autowired
    private ArticleService articleService;

    @PostMapping
    public Result add(@RequestBody @Validated Article article){
        articleService.add(article);
        return Result.success();
    }

    @GetMapping
    public Result<PageBean<Article>> list(
            Integer pageNum,
            Integer pageSize,
            @RequestParam(required = false) Integer categoryId,
            @RequestParam(required = false) String state
    ){
        PageBean<Article> pb = articleService.list(pageNum,pageSize,categoryId,state);
        return Result.success(pb);
    }

    @GetMapping("/detail")
    public Result<Article> detail(Integer id){
        Article article = articleService.detail(id);
        return Result.success(article);
    }

    @PutMapping
    public Result update(@RequestBody @Validated Article article){
        article.setUpdateTime(LocalDateTime.now());
        articleService.update(article);
        return Result.success();
    }

    @DeleteMapping
    public Result delete(Integer id){
        articleService.delete(id);
        return Result.success();
    }



//    @GetMapping("/list")
//    public Result<String> list(){
//    public Result<String> list(@RequestHeader(name = "Authorization") String token, HttpServletResponse response){
        //验证token
//        try{
//            Map<String, Object> claims = JwtUtil.parseToken(token);
//            return Result.success("所有的文章数据...");
//        }
//        catch (Exception e){
//            //http响应码未401
//            response.setStatus(401);
//            return Result.error("未登录");
//        }
//        return Result.success("所有的文章数据...");
//    }

}
