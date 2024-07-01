package com.wwey.utils;

import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class AMQPUtil {
    @Autowired
    private RabbitTemplate rabbitTemplate;

    public void SendDirect(String msg){
        String exchangeName = "wwey.direct";
        rabbitTemplate.convertAndSend(exchangeName,"wwey",msg);
    }
}
