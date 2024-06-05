INSERT INTO `member` (
                       `created_at`
                     ,`updated_at`
                     ,`email`
                     ,`nickname`
                     ,`password`
                     ,`is_tutorial`



)
VALUES (
         NOW()
       ,NOW()
       ,'dummy1@dummy.com'
       ,'dummy 1'
       ,'ssafy!123'
       ,true

)
     ,(
        NOW()
      ,NOW()
      ,'master@ssafy.com'
      ,'master'
      ,'$2a$10$8hYd.BRWqegZnhZ5lIQD/.oQwTAHe/cASFLWg4MJ5BA7eLbOcV2lK'
      ,true
);