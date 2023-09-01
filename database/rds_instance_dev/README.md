# 주의

개발편리성을 위해 pubilc으로 rds를 생성하였지만 Prod환경에서는 private subnet을 이용해야함!

Private subnet과 route53을 이용하여 vpc내부에서만 소통할수 있도록 구성해야함.
(ex : db.domain.internal)

어느정도 개발이 완료되면 private db생성 예정
