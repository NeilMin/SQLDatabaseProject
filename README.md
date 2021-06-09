<!--
 * @Author: your name
 * @Date: 2018-06-08 11:54:28
 * @LastEditTime: 2021-05-26 03:24:20
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /webapps/CSE132B-master/README.md
-->
# cse132

                    "with tmp as (select *  from 
					(select s.ssn, s.firstname, s.middlename, s.lastname , ccc.name, sum(ce.units) as sum_major_category_units from student as s ,undergraduate as u ,classes_taken_in_the_past as ce ,course as co ,degree_requirements as d ,department as dp ,course_category_conversion as ccc  where s.student_id = u.student_id     and s.ssn  = ?     and s.student_id = ce.student_id     and dp.department_name = ?     and  (d.cur_degree LIKE 'B.S.%' or d.cur_degree LIKE 'B.A.%')     and d.department_id = dp.department_id     and ce.course_id = ccc.course_id     and co.department_id = d.department_id     and co.course_id = ce.course_id group by s.ssn, s.firstname, s.middlename, s.lastname , ccc.name  ) as sub 
					right outer join 
					(select * from course_categories as cc  ,department as dpp ,degree_requirements as dd  where dpp.department_name = ? and (dd.cur_degree LIKE 'B.S.%' or dd.cur_degree LIKE 'B.A.%') and dpp.department_id = dd.department_id and cc.degree_id = dd.degree_id) as cc1 
					on sub.name = cc1.course_category) 
					
					select ssn,firstname,middlename,lastname,course_category, min_units, coalesce(sum_major_category_units,0) as sum_major_category_units, units_required from (select distinct(ssn), firstname, middlename, lastname from tmp where ssn is not null) as t1, ((select course_category, min_units, sum_major_category_units, (min_units-sum_major_category_units) as units_required  from tmp  where name = course_category) union (select course_category, min_units, sum_major_category_units, min_units as units_required from tmp  where name is null)) as t2 "





					"SELECT distinct stu.ssn, stu.firstname, stu.lastname, class1.title AS noClassTitle, class1.course_id AS noCourseId,      meeting_1.mDate AS noDay,      meeting_1.starttime AS noStart,      meeting_1.endTime AS noEnd,      class_2.title AS conflictingClassTitles,      class_2.course_id AS conflictingCourseId,      meeting_2.startTime AS conflictingStart,      meeting_2.endTime AS conflictingEnd,     c1.course_number as noCourse,     c2.course_number as nowCourse 
					
					FROM student stu, section section1, class class1, meeting meeting_1,      section section_2, class class_2, meeting meeting_2, course_enrollment stu_sec_2, course as c1, course as c2     ,meeting_dow as md, meeting_dow as md2 
					
					WHERE stu.ssn = ? AND
					 stu.student_id = stu_sec_2.student_id AND 
					stu_sec_2.section_id = section_2.section_id AND 
					section_2.class_id = class_2.class_id      AND 
					meeting_2.section_id = section_2.section_id AND 
					class_2.currently_offered = 'yes'      AND 
					section1.class_id = class1.class_id      AND 
					meeting_1.section_id = section1.section_id AND 
					class1.currently_offered = 'yes'     AND 
					CAST( meeting_2.startTime AS Time) < CAST(meeting_1.endTime AS Time)      AND
					 CAST(meeting_2.endTime AS Time) > CAST(meeting_1.startTime AS Time)     and
					  meeting_2.meeting_id = md2.meeting_id     and
					   meeting_1.meeting_id = md.meeting_id     and
					    md.dow = md2.dow     AND
						 meeting_2.section_id <> meeting_1.section_id     and
						  class1.course_id = c1.course_id     and
						   class_2.course_id = c2.course_id "

		
                    





                    
                    
