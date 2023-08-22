Implementationen zur Bachelorarbeit Adaptive Finite Elemente für Lineare Elastizität von Theo Koppenhöfer

Folgende Hauptprogramme stehen zur Auswahl:
- main_locking: Führt die Versuchsreihe zum ersten Benchmark mit dem Quadratischen Gebiet aus. Wenn man nicht allzu lange auf die Ausführung warten möchte, kann man max_dof heruntersetzen.
- main_adaptivity: Führt die Versuchsreihe zum zweiten Benchmark auf dem L-förmigen Gebiet aus. Wenn man auch hier ungeduldig ist, kann man max_dofs modifizieren.
- main_plotExactSoln: Plottet die Anfangsbedingungen und die Lösung des Benchmarks auf dem quadratischen Gebiet und auf dem L-förmigen Gebiet.
- main_squarePull: Plottet das Beispiel aus der Einleitung.
- main_cubeWhirl: Dieses Problem wird zwar nicht im Textteil der Bachelorarbeit erwähnt, zeigt aber, dass das Programm auch mit 3-dimensionalen Problemen funktioniert.

Bemerkung: Für die Ausführung ist das Symbolic Math Toolbox von MATLAB notwendig.

Die Implementation orientiert sich hauptsächlich an 
[Alberty et al.] J. Alberty, C. Carstensen, S. A. Funken, and R. Klose. Matlab implementation of the finite element method in elasticity. Computing, 69(3):239–263, 2002.
[Carstensen et al.] C. Carstensen, M. Eigel, and J. Gedicke. Computational competition of symmetric mixed FEM in linear elasticity. Comput. Methods Appl. Mech. Engrg., 200(41-44):2903–2915, 2011.
