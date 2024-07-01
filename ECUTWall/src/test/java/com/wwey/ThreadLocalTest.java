package com.wwey;

import org.junit.jupiter.api.Test;

public class ThreadLocalTest {

    @Test
    public void testThreadLocalSetAndGet(){
        //提供一个ThreadLocal对象
        ThreadLocal tl = new ThreadLocal();

        //开启两个线程
        new Thread(()->{
            tl.set("鸣人");
            System.out.println(Thread.currentThread().getName()+" : "+tl.get());
            System.out.println(Thread.currentThread().getName()+" : "+tl.get());
            System.out.println(Thread.currentThread().getName()+" : "+tl.get());
        },"红色").start();


        new Thread(()->{
            tl.set("佐助");
            System.out.println(Thread.currentThread().getName()+" : "+tl.get());
            System.out.println(Thread.currentThread().getName()+" : "+tl.get());
            System.out.println(Thread.currentThread().getName()+" : "+tl.get());
        },"紫色").start();
    }

}
