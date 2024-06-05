package com.c206.backend.domain.member.service;

import com.c206.backend.domain.member.exception.redis.RedisError;
import com.c206.backend.domain.member.exception.redis.RedisException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.HashOperations;
import org.springframework.data.redis.core.ListOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

@Slf4j
@Component
@RequiredArgsConstructor
public class RedisService {
    private final RedisTemplate<String, Object> redisTemplate;
    public void setValues(String key, String data,Long refreshExpireMs ) {
        try{
            ValueOperations<String, Object> values = redisTemplate.opsForValue();
            values.set(key, data, refreshExpireMs , TimeUnit.MILLISECONDS);
        }catch (Exception e){
            throw new RedisException(RedisError.FAIL_TO_SET_VALUE);
        }

    }


    public void setValuesToList(String key, String data, Long refreshExpireMs ) {
        ListOperations<String, Object> listOper = redisTemplate.opsForList();
        listOper.rightPush(key, data);
        redisTemplate.expire(key, refreshExpireMs, TimeUnit.MILLISECONDS);
//        values.set(key, data, refreshExpireMs , TimeUnit.MILLISECONDS);
    }



    @Transactional(readOnly = true)
    public String getValues(String key) {
        try{
            ValueOperations<String, Object> values = redisTemplate.opsForValue();
            if (values.get(key) == null) {
                return "false";
            }
            return (String) values.get(key);
        } catch (Exception e){
            throw new RedisException(RedisError.FAIL_TO_GET_VALUE);
        }
    }

    @Transactional(readOnly = true)
    public List<Object> getValuesToList(String key) {
        ListOperations<String, Object> listOperations = redisTemplate.opsForList();
        return listOperations.range(key, 0, -1); // -1은 모든 요소를 가져오기 위한 인덱스입니다.
    }


    public void deleteValues(String key) {
        try{
            redisTemplate.delete(key);
        }catch (Exception e){
            throw new RedisException(RedisError.FAIL_TO_DELETE_VALUE);
        }
    }

    public void expireValues(String key, int timeout) {
        redisTemplate.expire(key, timeout, TimeUnit.MILLISECONDS);
    }

    public void setHashOps(String key, Map<String, String> data) {
        HashOperations<String, Object, Object> values = redisTemplate.opsForHash();
        values.putAll(key, data);
    }

    @Transactional(readOnly = true)
    public String getHashOps(String key, String hashKey) {
        HashOperations<String, Object, Object> values = redisTemplate.opsForHash();
        return Boolean.TRUE.equals(values.hasKey(key, hashKey)) ? (String) redisTemplate.opsForHash().get(key, hashKey) : "";
    }

    public void deleteHashOps(String key, String hashKey) {
        HashOperations<String, Object, Object> values = redisTemplate.opsForHash();
        values.delete(key, hashKey);
    }

    public boolean checkExistsValue(String value) {
        try{
            return !value.equals("false");
        }catch (Exception e){
            throw new RedisException(RedisError.FAIL_TO_CHECK_IS_EXIST_VALUE);
        }
    }
}
