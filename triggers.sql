-- Part 5 trigger

CREATE function updateCPQG() returns trigger as
$body$
   begin
       if(TG_OP='UPDATE') then
          
              if(OLD.grade = 'A+' or OLD.grade ='A' or OLD.grade = 'A-')            
              then  UPDATE CPQG set countas = countas -1 
              where old.course_id = CPQG.course_id and old.quarter = CPQG.quarter and old.year = CPQG.year;          
              elseif(OLD.grade = 'B+' or OLD.grade ='B' or OLD.grade = 'B-')            
              then  UPDATE CPQG set countbs = countbs -1 
              where old.course_id = CPQG.course_id and old.quarter = CPQG.quarter and old.year = CPQG.year;
              elseif(OLD.grade = 'C+' or OLD.grade ='C' or OLD.grade = 'C-')            
              then  UPDATE CPQG set countcs = countcs -1 
              where old.course_id = CPQG.course_id and old.quarter = CPQG.quarter and old.year = CPQG.year;
              elseif(OLD.grade = 'D+' or OLD.grade ='D' or OLD.grade = 'D-')            
              then  UPDATE CPQG set countds = countds -1 
              where old.course_id = CPQG.course_id and old.quarter = CPQG.quarter and old.year = CPQG.year;
               elseif(OLD.grade = 'F')            
              then  UPDATE CPQG set countothers = countothers -1 
              where old.course_id = CPQG.course_id and old.quarter = CPQG.quarter and old.year = CPQG.year;
              END IF;


              if(NEW.grade = 'A+' or NEW.grade ='A' or NEW.grade = 'A-')            
              then  UPDATE CPQG set countas = countas + 1 
              where new.course_id = CPQG.course_id and new.quarter = CPQG.quarter and new.year = CPQG.year;          
              elseif(new.grade = 'B+' or new.grade ='B' or new.grade = 'B-')            
              then  UPDATE CPQG set countbs = countbs + 1 
              where new.course_id = CPQG.course_id and new.quarter = CPQG.quarter and new.year = CPQG.year;
              elseif(new.grade = 'C+' or new.grade ='C' or new.grade = 'C-')            
              then  UPDATE CPQG set countcs = countcs +1 
              where new.course_id = CPQG.course_id and new.quarter = CPQG.quarter and new.year = CPQG.year;
              elseif(new.grade = 'D+' or new.grade ='D' or new.grade = 'D-')            
              then  UPDATE CPQG set countds = countds +1 
              where new.course_id = CPQG.course_id and new.quarter = CPQG.quarter and new.year = CPQG.year;
               elseif(new.grade = 'F')            
              then  UPDATE CPQG set countothers = countothers +1 
              where new.course_id = CPQG.course_id and new.quarter = CPQG.quarter and new.year = CPQG.year;
              END IF;



              if(OLD.grade = 'A+' or OLD.grade ='A' or OLD.grade = 'A-')            
              then  UPDATE CPG set gradea = gradea -1 
              where old.course_id = CPG.course_id and CPG.faculty_id = (select distinct faculty_teach.faculty_id from faculty_teach where faculty_teach.quarter = new.quarter  and faculty_teach.course = new.course_id);   
              elseif(OLD.grade = 'B+' or OLD.grade ='B' or OLD.grade = 'B-')            
              then  UPDATE CPG set gradeb = gradeb -1 
              where old.course_id = CPG.course_id and CPG.faculty_id = (select distinct faculty_teach.faculty_id from faculty_teach where faculty_teach.quarter = new.quarter  and faculty_teach.course = new.course_id);
              elseif(OLD.grade = 'C+' or OLD.grade ='C' or OLD.grade = 'C-')            
              then  UPDATE CPG set gradec = gradec -1 
              where old.course_id = CPG.course_id and CPG.faculty_id = (select distinct faculty_teach.faculty_id from faculty_teach where faculty_teach.quarter = new.quarter  and faculty_teach.course = new.course_id);
              elseif(OLD.grade = 'D+' or OLD.grade ='D' or OLD.grade = 'D-')            
              then  UPDATE CPG set graded = graded -1 
              where old.course_id = CPG.course_id and CPG.faculty_id = (select distinct faculty_teach.faculty_id from faculty_teach where faculty_teach.quarter = new.quarter  and faculty_teach.course = new.course_id);
              elseif(OLD.grade = 'F')            
              then  UPDATE CPG set gradeother = gradeother -1 
              where old.course_id = CPG.course_id and CPG.faculty_id = (select distinct faculty_teach.faculty_id from faculty_teach where faculty_teach.quarter = new.quarter  and faculty_teach.course = new.course_id);
              END IF;




              if(NEW.grade = 'A+' or NEW.grade ='A' or NEW.grade = 'A-')            
              then  UPDATE CPG set gradea = gradea + 1 
              where new.course_id = CPG.course_id and CPG.faculty_id = (select distinct faculty_teach.faculty_id from faculty_teach where faculty_teach.quarter = new.quarter  and faculty_teach.course = new.course_id);         
              elseif(new.grade = 'B+' or new.grade ='B' or new.grade = 'B-')            
              then  UPDATE CPG set gradeb = gradeb + 1 
              where new.course_id = CPG.course_id and CPG.faculty_id = (select distinct faculty_teach.faculty_id from faculty_teach where faculty_teach.quarter = new.quarter  and faculty_teach.course = new.course_id);
              elseif(new.grade = 'C+' or new.grade ='C' or new.grade = 'C-')            
              then  UPDATE CPG set gradec = gradec +1 
              where new.course_id = CPG.course_id and CPG.faculty_id = (select distinct faculty_teach.faculty_id from faculty_teach where faculty_teach.quarter = new.quarter  and faculty_teach.course = new.course_id);
              elseif(new.grade = 'D+' or new.grade ='D' or new.grade = 'D-')            
              then  UPDATE CPG set graded = graded +1 
              where new.course_id = CPG.course_id and CPG.faculty_id = (select distinct faculty_teach.faculty_id from faculty_teach where faculty_teach.quarter = new.quarter  and faculty_teach.course = new.course_id);
               elseif(new.grade = 'F')            
              then  UPDATE CPG set gradeother = gradeother +1 
              where new.course_id = CPG.course_id and CPG.faculty_id = (select distinct faculty_teach.faculty_id from faculty_teach where faculty_teach.quarter = new.quarter  and faculty_teach.course = new.course_id);
              END IF;


	ELSEIF(TG_OP='INSERT') then 
	       
              IF EXISTS( select CPQG.course_id FROM CPQG where new.course_id = CPQG.course_id and 
                        new.quarter = CPQG.quarter and new.year = CPQG.year)
	      then 
                    
                 if(NEW.grade = 'A+' or NEW.grade ='A' or NEW.grade = 'A-')            
                 then  UPDATE CPQG set countas = countas + 1 
                 where new.course_id = CPQG.course_id and new.quarter = CPQG.quarter and new.year = CPQG.year;          
                 elseif(new.grade = 'B+' or new.grade ='B' or new.grade = 'B-')            
                 then  UPDATE CPQG set countbs = countbs + 1 
                 where new.course_id = CPQG.course_id and new.quarter = CPQG.quarter and new.year = CPQG.year;
                 elseif(new.grade = 'C+' or new.grade ='C' or new.grade = 'C-')            
                 then  UPDATE CPQG set countcs = countcs +1 
                 where new.course_id = CPQG.course_id and new.quarter = CPQG.quarter and new.year = CPQG.year;
                 elseif(new.grade = 'D+' or new.grade ='D' or new.grade = 'D-')            
                 then  UPDATE CPQG set countds = countds +1 
                 where new.course_id = CPQG.course_id and new.quarter = CPQG.quarter and new.year = CPQG.year;
                 elseif(new.grade = 'F')            
                 then  UPDATE CPQG set countothers = countothers +1 
                 where new.course_id = CPQG.course_id and new.quarter = CPQG.quarter and new.year = CPQG.year;
                 END IF;

	      ELSEIF EXISTS (select faculty_teach.faculty_id from faculty_teach where new.course_id = faculty_teach.course and 
                        new.quarter = faculty_teach.quarter )
                 then

                 if(NEW.grade = 'A+' or NEW.grade ='A' or NEW.grade = 'A-')
                 then INSERT INTO CPQG(course_id, faculty_id, quarter, year, countas, countbs, countcs, countds, countothers)
                 values(new.course_id, (select faculty_teach.faculty_id from faculty_teach where new.course_id = faculty_teach.course and 
                        new.quarter = faculty_teach.quarter ), new.quarter, new.year, 1,0,0,0,0);

                 elseif(NEW.grade = 'B+' or NEW.grade ='B' or NEW.grade = 'B-') 
                 then INSERT INTO CPQG(course_id, faculty_id, quarter, year, countas, countbs, countcs, countds, countothers)
                 values(new.course_id, (select faculty_teach.faculty_id from faculty_teach where new.course_id = faculty_teach.course and 
                        new.quarter = faculty_teach.quarter ), new.quarter, new.year, 0,1,0,0,0);

                 elseif(NEW.grade = 'C+' or NEW.grade ='C' or NEW.grade = 'C-')
                 then INSERT INTO CPQG(course_id, faculty_id, quarter, year, countas, countbs, countcs, countds, countothers)
                 values(new.course_id, (select faculty_teach.faculty_id from faculty_teach where new.course_id = faculty_teach.course and 
                        new.quarter = faculty_teach.quarter ), new.quarter, new.year,0,0,1,0,0);

                 elseif(NEW.grade = 'D+' or NEW.grade ='D' or NEW.grade = 'D-')
                 then INSERT INTO CPQG(course_id, faculty_id, quarter, year, countas, countbs, countcs, countds, countothers)
                 values(new.course_id, (select faculty_teach.faculty_id from faculty_teach where new.course_id = faculty_teach.course and 
                        new.quarter = faculty_teach.quarter ), new.quarter, new.year, 0,0,0,1,0);

                 elseif(NEW.grade = F)
                 then INSERT INTO CPQG(course_id, faculty_id, quarter, year, countas, countbs, countcs, countds, countothers)
                 values(new.course_id, (select faculty_teach.faculty_id from faculty_teach where new.course_id = faculty_teach.course and 
                        new.quarter = faculty_teach.quarter ), new.quarter, new.year, 1,0,0,0,1);
             
                 END IF;
 	      END IF;


              IF EXISTS( select CPG.course_id FROM CPG where new.course_id = CPG.course_id)
	      then 
                    
				  if(NEW.grade = 'A+' or NEW.grade ='A' or NEW.grade = 'A-')            
				  then  UPDATE CPG set gradea = gradea + 1 
				  where new.course_id = CPG.course_id and CPG.faculty_id = (select distinct faculty_teach.faculty_id from faculty_teach where faculty_teach.quarter = new.quarter  and faculty_teach.course = new.course_id);         
				  elseif(new.grade = 'B+' or new.grade ='B' or new.grade = 'B-')            
				  then  UPDATE CPG set gradeb = gradeb + 1 
				  where new.course_id = CPG.course_id and CPG.faculty_id = (select distinct faculty_teach.faculty_id from faculty_teach where faculty_teach.quarter = new.quarter  and faculty_teach.course = new.course_id);
				  elseif(new.grade = 'C+' or new.grade ='C' or new.grade = 'C-')            
				  then  UPDATE CPG set gradec = gradec +1 
				  where new.course_id = CPG.course_id and CPG.faculty_id = (select distinct faculty_teach.faculty_id from faculty_teach where faculty_teach.quarter = new.quarter  and faculty_teach.course = new.course_id);
				  elseif(new.grade = 'D+' or new.grade ='D' or new.grade = 'D-')            
				  then  UPDATE CPG set graded = graded +1 
				  where new.course_id = CPG.course_id and CPG.faculty_id = (select distinct faculty_teach.faculty_id from faculty_teach where faculty_teach.quarter = new.quarter  and faculty_teach.course = new.course_id);
				   elseif(new.grade = 'F')            
				  then  UPDATE CPG set gradeother = gradeother +1 
				  where new.course_id = CPG.course_id and CPG.faculty_id = (select distinct faculty_teach.faculty_id from faculty_teach where faculty_teach.quarter = new.quarter  and faculty_teach.course = new.course_id);
				  END IF;

	      ELSEIF EXISTS (select faculty_teach.faculty_id from faculty_teach where new.course_id = faculty_teach.course and 
                        new.quarter = faculty_teach.quarter )
                 then

                 if(NEW.grade = 'A+' or NEW.grade ='A' or NEW.grade = 'A-')
                 then INSERT INTO CPG(course_id, faculty_id, gradea, gradeb, gradec, graded, gradeother)
                 values(new.course_id, (select faculty_teach.faculty_id from faculty_teach where new.course_id = faculty_teach.course and 
                        new.quarter = faculty_teach.quarter ), 1,0,0,0,0);

                 elseif(NEW.grade = 'B+' or NEW.grade ='B' or NEW.grade = 'B-')
                 then INSERT INTO CPG(course_id, faculty_id, gradea, gradeb, gradec, graded, gradeother)
                 values(new.course_id, (select faculty_teach.faculty_id from faculty_teach where new.course_id = faculty_teach.course and 
                        new.quarter = faculty_teach.quarter ), 0,1,0,0,0);
                 elseif(NEW.grade = 'C+' or NEW.grade ='C' or NEW.grade = 'C-')
                 then INSERT INTO CPG(course_id, faculty_id, gradea, gradeb, gradec, graded, gradeother)
                 values(new.course_id, (select faculty_teach.faculty_id from faculty_teach where new.course_id = faculty_teach.course and 
                        new.quarter = faculty_teach.quarter ), 0,0,1,0,0);
                 elseif(NEW.grade = 'D+' or NEW.grade ='D' or NEW.grade = 'D-')
                 then INSERT INTO CPG(course_id, faculty_id, gradea, gradeb, gradec, graded, gradeother)
                 values(new.course_id, (select faculty_teach.faculty_id from faculty_teach where new.course_id = faculty_teach.course and 
                        new.quarter = faculty_teach.quarter ), 0,0,0,1,0);
                 elseif(NEW.grade = 'F')
                 then INSERT INTO CPG(course_id, faculty_id, gradea, gradeb, gradec, graded, gradeother)
                 values(new.course_id, (select faculty_teach.faculty_id from faculty_teach where new.course_id = faculty_teach.course and 
                        new.quarter = faculty_teach.quarter ), 0,0,0,0,1);
		 END IF;
             
        END IF;
        END IF;
        RETURN NEW;
        END;
        $body$
        LANGUAGE plpgsql;
              
          

create trigger cpqgTrigger
AFTER INSERT OR UPDATE on historyofclasses
for each row 
execute procedure updateCPQG();




CREATE function updateCPQG() returns trigger as
$body$
   begin

   IF EXISTS (
            SELECT *
            FROM classes_taken_in_the_past ctp
            WHERE ctp.course_id = NEW.course_id and ctp.quarter = NEW.quarter)
    THEN 
        if(NEW.grade = 'A+' or NEW.grade ='A' or NEW.grade = 'A-')            
        then  UPDATE CPQG set countas = countas + 1 
        where NEW.course_id = CPQG.course_id and new.quarter = CPQG.quarter ;          
        elseif(new.grade = 'B+' or new.grade ='B' or new.grade = 'B-')            
        then  UPDATE CPQG set countbs = countbs + 1 
        where new.course_id = CPQG.course_id and new.quarter = CPQG.quarter;
        elseif(new.grade = 'C+' or new.grade ='C' or new.grade = 'C-')            
        then  UPDATE CPQG set countcs = countcs +1 
        where new.course_id = CPQG.course_id and new.quarter = CPQG.quarter;
        elseif(new.grade = 'D+' or new.grade ='D' or new.grade = 'D-')            
        then  UPDATE CPQG set countds = countds +1 
        where new.course_id = CPQG.course_id and new.quarter = CPQG.quarter;
        elseif(new.grade = 'F')            
        then  UPDATE CPQG set countothers = countothers +1 
        where new.course_id = CPQG.course_id and new.quarter = CPQG.quarter;
        END IF;

        if(NEW.grade = 'A+' or NEW.grade ='A' or NEW.grade = 'A-')            
        then  UPDATE CPG set gradea = gradea + 1 
        where new.course_id = CPG.course_id and CPG.faculty_id = (select distinct faculty_teach.faculty_id from faculty_teach where faculty_teach.quarter = new.quarter  and faculty_teach.course = new.course_id);         
        elseif(new.grade = 'B+' or new.grade ='B' or new.grade = 'B-')            
        then  UPDATE CPG set gradeb = gradeb + 1 
        where new.course_id = CPG.course_id and CPG.faculty_id = (select distinct faculty_teach.faculty_id from faculty_teach where faculty_teach.quarter = new.quarter  and faculty_teach.course = new.course_id);
        elseif(new.grade = 'C+' or new.grade ='C' or new.grade = 'C-')            
        then  UPDATE CPG set gradec = gradec +1 
        where new.course_id = CPG.course_id and CPG.faculty_id = (select distinct faculty_teach.faculty_id from faculty_teach where faculty_teach.quarter = new.quarter  and faculty_teach.course = new.course_id);
        elseif(new.grade = 'D+' or new.grade ='D' or new.grade = 'D-')            
        then  UPDATE CPG set graded = graded +1 
        where new.course_id = CPG.course_id and CPG.faculty_id = (select distinct faculty_teach.faculty_id from faculty_teach where faculty_teach.quarter = new.quarter  and faculty_teach.course = new.course_id);
        elseif(new.grade = 'F')            
        then  UPDATE CPG set gradeother = gradeother +1 
        where new.course_id = CPG.course_id and CPG.faculty_id = (select distinct faculty_teach.faculty_id from faculty_teach where faculty_teach.quarter = new.quarter  and faculty_teach.course = new.course_id);
        END IF;


    else
        if(NEW.grade = 'A+' or NEW.grade ='A' or NEW.grade = 'A-')
        then INSERT INTO CPQG(course_id, faculty_id, quarter, countas, countbs, countcs, countds, countothers)
        values(new.course_id, (select faculty_teach.faculty_id from faculty_teach where new.course_id = faculty_teach.course_id and 
            new.quarter = faculty_teach.teach_time ), new.quarter, 1,0,0,0,0);

        elseif(NEW.grade = 'B+' or NEW.grade ='B' or NEW.grade = 'B-') 
        then INSERT INTO CPQG(course_id, faculty_id, quarter, countas, countbs, countcs, countds, countothers)
        values(new.course_id, (select faculty_teach.faculty_id from faculty_teach where new.course_id = faculty_teach.course_id and 
            new.quarter = faculty_teach.teach_time ), new.quarter, 0,1,0,0,0);

        elseif(NEW.grade = 'C+' or NEW.grade ='C' or NEW.grade = 'C-')
        then INSERT INTO CPQG(course_id, faculty_id, quarter, countas, countbs, countcs, countds, countothers)
        values(new.course_id, (select faculty_teach.faculty_id from faculty_teach where new.course_id = faculty_teach.course_id and 
            new.quarter = faculty_teach.teach_time ), new.quarter,0,0,1,0,0);

        elseif(NEW.grade = 'D+' or NEW.grade ='D' or NEW.grade = 'D-')
        then INSERT INTO CPQG(course_id, faculty_id, quarter, countas, countbs, countcs, countds, countothers)
        values(new.course_id, (select faculty_teach.faculty_id from faculty_teach where new.course_id = faculty_teach.course_id and 
            new.quarter = faculty_teach.teach_time ), new.quarter, 0,0,0,1,0);

        elseif(NEW.grade = F)
        then INSERT INTO CPQG(course_id, faculty_id, quarter, countas, countbs, countcs, countds, countothers)
        values(new.course_id, (select faculty_teach.faculty_id from faculty_teach where new.course_id = faculty_teach.course_id and 
            new.quarter = faculty_teach.teach_time ), new.quarter, 1,0,0,0,1);
    
        END IF;

        if(NEW.grade = 'A+' or NEW.grade ='A' or NEW.grade = 'A-')
        then INSERT INTO CPG(course_id, faculty_id, gradea, gradeb, gradec, graded, gradeother)
        values(new.course_id, (select faculty_teach.faculty_id from faculty_teach where new.course_id = faculty_teach.course and 
            new.quarter = faculty_teach.quarter ), 1,0,0,0,0);

        elseif(NEW.grade = 'B+' or NEW.grade ='B' or NEW.grade = 'B-')
        then INSERT INTO CPG(course_id, faculty_id, gradea, gradeb, gradec, graded, gradeother)
        values(new.course_id, (select faculty_teach.faculty_id from faculty_teach where new.course_id = faculty_teach.course and 
            new.quarter = faculty_teach.quarter ), 0,1,0,0,0);
        elseif(NEW.grade = 'C+' or NEW.grade ='C' or NEW.grade = 'C-')
        then INSERT INTO CPG(course_id, faculty_id, gradea, gradeb, gradec, graded, gradeother)
        values(new.course_id, (select faculty_teach.faculty_id from faculty_teach where new.course_id = faculty_teach.course and 
            new.quarter = faculty_teach.quarter ), 0,0,1,0,0);
        elseif(NEW.grade = 'D+' or NEW.grade ='D' or NEW.grade = 'D-')
        then INSERT INTO CPG(course_id, faculty_id, gradea, gradeb, gradec, graded, gradeother)
        values(new.course_id, (select faculty_teach.faculty_id from faculty_teach where new.course_id = faculty_teach.course and 
            new.quarter = faculty_teach.quarter ), 0,0,0,1,0);
        elseif(NEW.grade = 'F')
        then INSERT INTO CPG(course_id, faculty_id, gradea, gradeb, gradec, graded, gradeother)
        values(new.course_id, (select faculty_teach.faculty_id from faculty_teach where new.course_id = faculty_teach.course and 
            new.quarter = faculty_teach.quarter ), 0,0,0,0,1);
		 END IF;
         
    END IF;
    
    RETURN NEW;
    END;
    $body$
    LANGUAGE plpgsql;
              
          

create trigger cpqgTrigger
AFTER INSERT on classes_taken_in_the_past
for each row 
execute procedure updateCPQG();
