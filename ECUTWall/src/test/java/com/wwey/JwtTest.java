package com.wwey;

import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.interfaces.Claim;
import com.auth0.jwt.interfaces.DecodedJWT;
import org.junit.jupiter.api.Test;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

public class JwtTest {

    @Test
    public void testGen() {
        Map<String, Object> clasim = new HashMap<>();
        clasim.put("id", 1);
        clasim.put("username", "张三");

        //生成jwt的代码
        String token = JWT.create()
                .withClaim("user", clasim)//添加载荷
                .withExpiresAt(new Date(System.currentTimeMillis() + 1000 * 60 * 60 * 12))//添加过期时间
                .sign(Algorithm.HMAC256("wwey"));//指定算法，配置密钥
        System.out.println(token);
    }

//    @Test
//    public void testParse(){
//        //定义字符串，模拟用户传来的token
//        String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9" +
//                ".eyJ1c2VyIjp7ImlkIjoxLCJ1c2VybmFtZSI6IuW8oOS4iSJ9LCJleHAiOjE3MTQwMzIyNDJ9" +
//                ".J-N71CeHPY2Z2dxen3bYQjfV5CRHkSlBPxuUc-_7INc";
//        JWTVerifier jwtVerifier = JWT.require(Algorithm.HMAC256("wwey")).build();
//
//        DecodedJWT verify = jwtVerifier.verify(token);//验证token，生成一个解析后的JWT对象
//        Map<String, Claim> claims = verify.getClaims();
//        System.out.println(claims);
//
//        //篡改头部or载荷部分数据，验证失败
//        //密钥不同，验证失败
//        //时间过期，验证失败
//    }
}
