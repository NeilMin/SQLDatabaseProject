<!--
 * @Author: your name
 * @Date: 2018-06-08 11:54:28
 * @LastEditTime: 2021-06-11 08:42:34
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /webapps/CSE132B-master/README.md
-->
# cse132
						   select distinct cc.course_id, cc.course_number, f.fname, f.faculty_id  
						   from classes_taken_in_the_past as ctp, course as cc, faculty_teach as ft, faculty as f 
						   where ctp.course_id = cc.course_id     and
						    ft.faculty_id = f.faculty_id     and
							cc.course_id = ?     and
							ft.course_id = cc.course_id 
							order by cc.course_id");


"with 
ac as (select distinct c.course_id, c.course_number, ft.teach_time, f.faculty_name, ctp.grade , count(ctp.student_id) as num from course as c, faculty_teach as ft, faculty as f, classes_taken_in_the_past as ctp where c.course_id = ft.course_id     and f.faculty_id = ft.faculty_id     and c.course_id = ?     and f.faculty_id = ?     and ft.teach_time = ?     and ctp.course_id = c.course_id     and ctp.quarter = ft.teach_time     and ctp.grading_option LIKE 'letter%' group by c.course_id, c.course_number, ft.teach_time, f.faculty_name, ctp.grade )  ,
la as (select ac.course_id, ac.grade, ac.num from ac where substring(ac.grade from 1 for 2) = 'A' ) , 
lb as (select ac.course_id, ac.grade, ac.num from ac where substring(ac.grade from 1 for 2) = 'B' ) , 
lc as (select ac.course_id, ac.grade, ac.num from ac where substring(ac.grade from 1 for 2) = 'C' ) , ld as (select ac.course_id, ac.grade, ac.num from ac where substring(ac.grade from 1 for 2) = 'D' )   , 
other as (     select ac.course_id, sum(ac.num) as num from ac where substring(ac.grade from 1 for 2) != 'C' and substring(ac.grade from 1 for 2) != 'A' and substring(ac.grade from 1 for 2) != 'B' and substring(ac.grade from 1 for 2) != 'D' group by ac.course_id  )  
select distinct ac.course_id, ac.course_number  , coalesce(la.num,0) as a  , coalesce(lb.num,0) as b  , coalesce(lc.num,0) as c , coalesce(ld.num,0) as d , coalesce(other.num,0) as Other from  ac   left join lc on ac.course_id = lc.course_id  left join la on ac.course_id = la.course_id   left join lb on ac.course_id = lb.course_id    left join ld on ac.course_id = ld.course_id    left join other on ac.course_id = other.course_id 


		
                    





                    
                    
