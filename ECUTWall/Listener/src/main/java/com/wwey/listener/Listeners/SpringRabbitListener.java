package com.wwey.listener.Listeners;

import lombok.extern.slf4j.Slf4j;
import org.springframework.amqp.core.ExchangeTypes;
import org.springframework.amqp.rabbit.annotation.Exchange;
import org.springframework.amqp.rabbit.annotation.Queue;
import org.springframework.amqp.rabbit.annotation.QueueBinding;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.messaging.converter.MessageConversionException;
import org.springframework.stereotype.Component;

@Slf4j
@Component
public class SpringRabbitListener {

    @RabbitListener(bindings = @QueueBinding(
            value = @Queue(name = "wwey", durable = "true"),
            exchange = @Exchange(name = "wwey.direct", type = ExchangeTypes.DIRECT),
            key = {"wwey"}
    ))
    public void listenQueueMessage(String msg) throws InterruptedException{
        System.out.println("收到了direct指令队列的消息" + msg);
    }

}
