
# Table of Contents

1.  [plists and alists in elisp](#orga1e7274)
    1.  [Ways to manipulate plists and alists in elisp](#org87a3dc1)



<a id="orga1e7274"></a>

# TODO plists and alists in elisp


<a id="org87a3dc1"></a>

## Ways to manipulate plists and alists in elisp

        (defstruct person
          name
          age)
    
        ;; Create instances of the person structure
        (setq john (make-person :name "John" :age 25 ))
        (setq alice (make-person :name "Alice" :age 30 ))
        (setq bob (make-person :name "Bob" :age 45 ))
    
        ;; Build a list of person structures
        (setq li (list john alice bob 1 "napis"))
        (print li)
        ;; (setq pli (
        (setq pli '("JJ" john "BB" (make-person :name "Bob" :age 45 )))
        (print pli)
        (plist-put pli "AA" alice)
        (print pli)
        (print (plist-get pli "BB"))
    
    
      ;; (nth 0 persons)
    
    
    ;; Define a simple structure using defstruct
    (defstruct person
      name
      age)
    
    ;; Create two instances of the person structure
    (setq person1 (make-person :name "John" :age 30))
    (setq person2 (make-person :name "Jane" :age 25))
    
    ;; Create a property list and add the person instances
    (setq plist (list :person1 person1 :person2 person2))
    
    ;; Create an association list and add the person instances
    (setq alist (list (cons :person1 person1) (cons :person2 person2)))
    
    ;; Retrieve items from the property list
    (princ "Person 1's name from the plist is: ")
    (print (person-name (plist-get plist :person1)))
    (princ "Person 2's age from the plist is: ")
    (print (person-age (plist-get plist :person2)))
    
    ;; Retrieve items from the association list
    (princ "Person 1's name from the alist is: ")
    (print (person-name (cdr (assoc :person1 alist))))
    (princ "Person 2's age from the alist is: ")
    (print (person-age (cdr (assoc :person2 alist))))

