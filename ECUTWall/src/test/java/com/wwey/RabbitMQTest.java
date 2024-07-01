package com.wwey;

import org.junit.jupiter.api.Test;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
public class RabbitMQTest {
    @Autowired
    private RabbitTemplate rabbitTemplate;

    @Test
    void testSendDirect(){
        String exchangeName = "wwey.direct";
        String msg = "hello, 拿的真快呀!";
        rabbitTemplate.convertAndSend(exchangeName,"wwey",msg);
    }
}
