package com.c206.backend.global.config;

import com.c206.backend.global.common.dto.RedisInfo;
import io.lettuce.core.ReadFrom;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.connection.RedisStandaloneConfiguration;
import org.springframework.data.redis.connection.RedisStaticMasterReplicaConfiguration;
import org.springframework.data.redis.connection.lettuce.LettuceClientConfiguration;
import org.springframework.data.redis.connection.lettuce.LettuceConnectionFactory;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.repository.configuration.EnableRedisRepositories;
import org.springframework.data.redis.serializer.StringRedisSerializer;

@EnableRedisRepositories
@Configuration
@RequiredArgsConstructor
public class RedisConfig {

//    @Value("${spring.data.redis.master.host}")
//    private String host_master;
//
//    @Value("${spring.data.redis.master.port}")
//    private int port_master;
//    @Value("${spring.data.redis.slave-a.host}")
//    private String host_slave_a;
//
//    @Value("${spring.data.redis.slave-a.port}")
//    private int port_slave_a;
//    @Value("${spring.data.redis.master.host}")
//    private String host_slave_b;
//
//    @Value("${spring.data.redis.master.port}")
//    private int port_slave_b;

    private final RedisInfo info;
//    @Bean
//    public RedisConnectionFactory redisConnectionFactory() {
////        RedisStandaloneConfiguration redisStandaloneConfiguration = new RedisStandaloneConfiguration();
////        redisStandaloneConfiguration.setHostName(host_master);
////        redisStandaloneConfiguration.setPort(port_master);
////        return new LettuceConnectionFactory(redisStandaloneConfiguration);
//
//        LettuceClientConfiguration clientConfig = LettuceClientConfiguration.builder()
//            .readFrom(ReadFrom.REPLICA_PREFERRED)	// replica에서 우선적으로 읽지만 replica에서 읽어오지 못할 경우 Master에서 읽어옴
//            .build();
//
//        RedisStaticMasterReplicaConfiguration slaveConfig = new RedisStaticMasterReplicaConfiguration(host_master, port_master);
//
//        slaveConfig.addNode(host_slave_a, port_slave_a);
//        slaveConfig.addNode(host_slave_b, port_slave_b);
//
//        return new LettuceConnectionFactory(slaveConfig, clientConfig);
//    }

    @Bean
    public LettuceConnectionFactory redisConnectionFactory(){
        LettuceClientConfiguration clientConfig = LettuceClientConfiguration.builder()
            .readFrom(ReadFrom.REPLICA_PREFERRED)	// replica에서 우선적으로 읽지만 replica에서 읽어오지 못할 경우 Master에서 읽어옴
            .build();

        System.out.println("++++++++++++++++++++++++++++++++++++++++++");
        System.out.println(info.getMaster().getHost()+" "+info.getMaster().getPort());
        System.out.println(info.getSlaves().get(0).getHost()+" "+info.getSlaves().get(0).getPort());
        System.out.println(info.getSlaves().get(1).getHost()+" "+info.getSlaves().get(1).getPort());
        System.out.println("++++++++++++++++++++++++++++++++++++++++++");
        // replica 설정
        RedisStaticMasterReplicaConfiguration slaveConfig = new RedisStaticMasterReplicaConfiguration(info.getMaster().getHost(), info.getMaster().getPort());
        // 설정에 slave 설정 값 추가
        info.getSlaves().forEach(slave -> slaveConfig.addNode(slave.getHost(), slave.getPort()));


        return new LettuceConnectionFactory(slaveConfig, clientConfig);
    }

    @Bean
    public RedisTemplate<String, Object> redisTemplate() {
        RedisTemplate<String, Object> redisTemplate = new RedisTemplate<>();
        redisTemplate.setConnectionFactory(redisConnectionFactory());
        redisTemplate.setKeySerializer(new StringRedisSerializer());
        redisTemplate.setValueSerializer(new StringRedisSerializer());
        return redisTemplate;
    }

}
