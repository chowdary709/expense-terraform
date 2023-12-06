1. create vpc.
2. create subnets 4 ( 2 private, 2 public & AZ 1, AZ 2).
3. create IGW aratching for vpc.
4. create one elastic ip.
5. create nat gateway (nat).
6. create 2 route tables (1 public, 1 private ).
7. add igw to public route, nat gateway to private route.
8. aratching public route public subnet, private route private subnet.
9. create preeing connection.
10. add preeing connection to `public route , private route` & `default route from default vpc.`