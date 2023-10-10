; ##########################
; RECIPES
; ##########################
; 
; scrambled eggs: eggs 2, butter 100
; tuna sandwich: tuna 1, bread 100
; burgers: meet 200, bread 100
; butter chicken: chicken 200, butter 100 
; salad: vegetables 150
; 
; ##########################
; TEMPLATES
; ##########################

(deftemplate ingredient
   (slot name (type SYMBOL))
   (slot quantity (type NUMBER))
   (slot unit (type SYMBOL))
)
; --------------------------------------------------------------------------
(deftemplate user-preferences
   (slot quick-preparation (type SYMBOL)) 
   (slot healthy-meal (type SYMBOL)) 
   (slot vegan-meal (type SYMBOL)) 
)

; ##########################
; FACTS
; ##########################

(deffacts init
    (ingredient (name egg) (quantity 100) (unit pieces))
    (ingredient (name butter) (quantity 100) (unit grams))
    (ingredient (name tuna) (quantity 3) (unit cans))
    (ingredient (name bread) (quantity 80) (unit grams))
    (ingredient (name meat) (quantity 100) (unit grams))
    (ingredient (name chicken) (quantity 200) (unit grams))
    (ingredient (name vegetables) (quantity 150) (unit grams))
    (answer-q1 empty)
    (answer-q2 empty)
    (answer-q3 empty)
    (show-results FALSE)
    (flag1 TRUE)
    (flag2 TRUE)
    (flag3 TRUE)
    (flag4 TRUE)
    (flag5 TRUE)
    (flag6 TRUE)
    (flag7 TRUE)
    (flag8 TRUE)
    (flag9 TRUE)
    (flag10 TRUE)
)

; ##########################
; FUCNTIONS
; ##########################

(deffunction ask-question (?text)
    (bind ?valid FALSE)
    (while (not ?valid)
        (printout t ?text crlf)
        (bind ?answer (read))
        (if (or (eq ?answer yes) (eq ?answer no))
            then
                (bind ?valid TRUE)
                (return ?answer)
            else
                (if (or (eq ?answer stop) (eq ?answer halt))
                    then
                        (halt)
                )
            
        )
    )
)

; ##########################
; MEAL RULES
; ##########################

(defrule can-make-burgers
    ?adr <- (flag1 TRUE)
    (show-results TRUE)
    (answer-q1 no)
    (answer-q2 no)
    (answer-q3 no)
    (ingredient (name bread) (quantity ?bread-qty&:(>= ?bread-qty 100)) (unit grams))
    (ingredient (name meat) (quantity ?meat-qty&:(>= ?meat-qty 200)) (unit grams))
    =>
    (printout t "You can make burgers!" crlf)
    (retract ?adr)
    (assert (flag1 FALSE))
)
; --------------------------------------------------------------------------
(defrule can-not-make-burgers
    ?adr <- (flag2 TRUE)
    (show-results TRUE)
    (answer-q1 no)
    (answer-q2 no)
    (answer-q3 no)
    (ingredient (name bread) (quantity ?bread-qty) (unit grams))
    (ingredient (name meat) (quantity ?meat-qty) (unit grams))
    (or
        (ingredient (name bread) (quantity ?bread-qty&:(< ?bread-qty 100)) (unit grams))
        (ingredient (name meat) (quantity ?meat-qty&:(< ?meat-qty 200)) (unit grams))
    )
    =>
    (printout t "You need 100gr of Bread and 200gr of Meat to make burgers!" crlf)
    (printout t "(You have " ?meat-qty "gr of Meat and " ?bread-qty "gr of Bread)" crlf)
    (retract ?adr)
    (assert (flag2 FALSE))
)
; --------------------------------------------------------------------------
(defrule can-make-butter-chicken
    ?adr <- (flag3 TRUE)
    (show-results TRUE)
    (answer-q1 no)
    (answer-q2 no)
    (answer-q3 no)
    (ingredient (name chicken) (quantity ?chicken-qty&:(>= ?chicken-qty 200)) (unit grams))
    (ingredient (name butter) (quantity ?butter-qty&:(>= ?butter-qty 100)) (unit grams))
    =>
    (printout t "You can make butter chicken!" crlf)
    (retract ?adr)
    (assert (flag3 FALSE))
)
; --------------------------------------------------------------------------
(defrule can-not-make-butter-chicken
    ?adr <- (flag4 TRUE)
    (show-results TRUE)
    (answer-q1 no)
    (answer-q2 no)
    (answer-q3 no)
    (ingredient (name chicken) (quantity ?chicken-qty) (unit grams))
    (ingredient (name butter) (quantity ?butter-qty) (unit grams))
    (or
        (ingredient (name chicken) (quantity ?chicken-qty&:(< ?chicken-qty 200)) (unit grams))
        (ingredient (name butter) (quantity ?butter-qty&:(< ?butter-qty 100)) (unit grams))
    )
    =>
    (printout t "You need 200gr of Chicken and 100gr of Butter to make butter chicken!" crlf)
    (printout t "(You have " ?chicken-qty "gr of Chicken and " ?butter-qty "gr of Butter)" crlf)
    (retract ?adr)
    (assert (flag4 FALSE))
)
; --------------------------------------------------------------------------
(defrule can-make-tuna-sandwich
    ?adr <- (flag5 TRUE)
    (show-results TRUE)
    (or (answer-q1 yes) (answer-q2 yes))
    (answer-q3 no)
    (ingredient (name tuna) (quantity ?tuna-qty&:(>= ?tuna-qty 1)) (unit cans))
    (ingredient (name bread) (quantity ?bread-qty&:(>= ?bread-qty 100)) (unit grams))
    =>
    (printout t "You can make a tuna sandwich!" crlf)
    (retract ?adr)
    (assert (flag5 FALSE))
)
; --------------------------------------------------------------------------
(defrule can-not-make-tuna-sandwich
    ?adr <- (flag6 TRUE)
    (show-results TRUE)
    (or (answer-q1 yes) (answer-q2 yes))
    (answer-q3 no)
    (ingredient (name tuna) (quantity ?tuna-qty) (unit cans))
    (ingredient (name bread) (quantity ?bread-qty) (unit grams))
    ( or
        (ingredient (name tuna) (quantity ?tuna-qty) (unit cans))
        (ingredient (name bread) (quantity ?bread-qty) (unit grams))
    )
    =>
    (printout t "You need 1 can of Tuna and 100gr of Bread to make a tuna sandwich!" crlf)
    (printout t "(You have " ?tuna-qty " cans of Tuna and " ?bread-qty "gr of Bread)" crlf)
    (retract ?adr)
    (assert (flag6 FALSE))
)
; --------------------------------------------------------------------------
(defrule can-make-scrambled-eggs
    ?adr <- (flag7 TRUE)
    (show-results TRUE)
    (answer-q1 yes)
    (ingredient (name egg) (quantity ?egg-qty&:(>= ?egg-qty 2)) (unit pieces))
    (ingredient (name butter) (quantity ?butter-qty&:(>= ?butter-qty 100)) (unit grams))
    =>
    (printout t "You can make scrambled eggs!" crlf)
    (retract ?adr)
    (assert (flag7 FALSE))
)
; --------------------------------------------------------------------------
(defrule can-not-make-scrambled-eggs
    ?adr <- (flag8 TRUE)
    (show-results TRUE)
    (answer-q1 yes)
    (ingredient (name egg) (quantity ?egg-qty) (unit pieces))
    (ingredient (name butter) (quantity ?butter-qty) (unit grams))
    (or 
        (ingredient (name egg) (quantity ?egg-qty&:(< ?egg-qty 2)) (unit pieces))
        (ingredient (name butter) (quantity ?butter-qty&:(< ?butter-qty 100)) (unit grams))
    )
    =>
    (printout t "You need 2 Eggs and 100gr of Butter to make scrambled eggs!" crlf)
    (printout t "(You have " ?egg-qty " pieces of Eggs and " ?butter-qty "gr of Butter)" crlf)
    (retract ?adr)
    (assert (flag8 FALSE))
)
; --------------------------------------------------------------------------
(defrule can-make-salad
    ?adr <- (flag9 TRUE)
    (show-results TRUE)
    (or (answer-q1 yes) (answer-q2 yes) (answer-q3 yes))
    (ingredient (name vegetables) (quantity ?vegetables-qty&:(>= ?vegetables-qty 150)) (unit grams))
    =>
    (printout t "You can make salads!" crlf)
    (retract ?adr)
    (assert (flag9 FALSE))
)
; --------------------------------------------------------------------------
(defrule can-not-make-salad
    ?adr <- (flag10 TRUE)
    (show-results TRUE)
    (or (answer-q1 yes) (answer-q2 yes) (answer-q3 yes))
    (ingredient (name vegetables) (quantity ?vegetables-qty) (unit grams))
    (ingredient (name vegetables) (quantity ?vegetables-qty&:(< ?vegetables-qty 150)) (unit grams))
    =>
    (printout t "You need 150gr of Vegetables to make a salad!" crlf)
    (printout t "(You have " ?vegetables-qty "gr of Vegetables)" crlf)
    (retract ?adr)
    (assert (flag10 FALSE))
)

; ##########################
; MAIN
; ##########################

(defrule ask-q1
    ?adr1 <- (answer-q1 empty)
    (answer-q2 empty)
    (answer-q3 empty)
    =>
    (retract ?adr1)
    (bind ?answer (ask-question "Is quick preparation important to you? (yes/no): "))
    (assert (answer-q1 ?answer))
)
; --------------------------------------------------------------------------
;(neq answer-q1 null)  why doesnt this work ?????????????? why should I use test or use this:
;(answer-q1 ?answer1&:(or (eq ?answer1 yes) (eq ?answer1 no)))
(defrule ask-q2
    (not (answer-q1 empty))
    ?adr2 <- (answer-q2 empty)
    (answer-q3 empty)
    =>
    (retract ?adr2)
    (bind ?answer (ask-question "Do you prefer a healthy food? (yes/no): "))
    (assert (answer-q2 ?answer))
)
; --------------------------------------------------------------------------
(defrule ask-q3
    (not (answer-q1 empty))
    (not (answer-q2 empty))
    ?adr1 <- (answer-q3 empty)
    ?adr2 <- (show-results FALSE)
    =>
    (retract ?adr1 ?adr2)
    (bind ?answer (ask-question "Are you a Vegan? (yes/no): "))
    (assert 
        (answer-q3 ?answer)
        (show-results TRUE)
    )
    (printout t "=================================" crlf)
    (printout t "============= ANSWER ============" crlf)
    (printout t "=================================" crlf)
    (printout t "" crlf)
)
; --------------------------------------------------------------------------
(defrule start-over
    (salience -10)
    ?adr1 <- (answer-q1 ?answer1)
    ?adr2 <- (answer-q2 ?answer2)
    ?adr3 <- (answer-q3 ?answer3)
    ?adr4 <- (show-results TRUE)
    ?adr5 <- (flag1 ?bool1)
    ?adr6 <- (flag2 ?bool2)
    ?adr7 <- (flag3 ?bool3)
    ?adr8 <- (flag4 ?bool4)
    ?adr9 <- (flag5 ?bool5)
    ?adr10 <- (flag6 ?bool6)
    ?adr11 <- (flag7 ?bool7)
    ?adr12 <- (flag8 ?bool8)
    ?adr13 <- (flag9 ?bool9)
    ?adr14 <- (flag10 ?bool10)
    (not (answer-q1 empty))
    (not (answer-q2 empty))
    (not (answer-q3 empty))
    =>
    (retract ?adr1 ?adr2 ?adr3 ?adr4)
    (retract ?adr5 ?adr6 ?adr7 ?adr8 ?adr9 ?adr10 ?adr11 ?adr12 ?adr13 ?adr14)
    (assert 
        (answer-q1 empty)
        (answer-q2 empty)
        (answer-q3 empty)
        (show-results FALSE)
        (flag1 TRUE)
        (flag2 TRUE)
        (flag3 TRUE)
        (flag4 TRUE)
        (flag5 TRUE)
        (flag6 TRUE)
        (flag7 TRUE)
        (flag8 TRUE)
        (flag9 TRUE)
        (flag10 TRUE)
    )
    (printout t "=================================" crlf)
    (printout t "============= WELCOME ===========" crlf)
    (printout t "=================================" crlf)
)

