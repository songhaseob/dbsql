join 1
SELECT lprod.lprod_gu, lprod.lprod_nm, prod.prod_id,prod.prod_name
FROM lprod JOIN prod ON(lprod.lprod_gu = prod.prod_lgu)
ORDER BY prod_id;

join 2
SELECT buyer_id, buyer_name, prod_id,prod_name
FROM prod JOIN buyer ON(prod.prod_buyer = buyer.buyer_id)
ORDER BY prod_id;

join3
1. 테이블 기술
2. 연결조건


ORACLE
SELECT member.mem_id, member.mem_name, prod.prod_id, prod.prod_name, cart.cart_qty
FROM member, cart, prod
WHERE member.mem_id = cart.cart_member AND cart.cart_prod = prod.prod_id;

ANSI-SQL]
테이블 JOIN 테이블 ON
 JOIN 테이블 ON
SELECT  member.mem_id, member.mem_name, prod.prod_id, prod.prod_name, cart.cart_qty
FROM member.mem_id JOIN cart ON ( member.mem_id = cart.cart_memeber)
                   JOIN prod ON ( cart.cart_prod = prod.prod_id);




