:-include(game).

solve_dfs(Problem, State, _History, []) :-
    final_state(Problem, State).

solve_dfs(Problem, State, History, Moves) :-
    movement(State, Move, SokobanMoves),
    append([SokobanMoves, [Move], AnotherMoves], Moves),
    update(State, Move, NewState),
    \+ member(NewState, History),
    solve_dfs(Problem, NewState, [NewState|History], AnotherMoves).

solve_problem(Problem, Solution) :-
    initial_state(Problem, Initial),
    solve_dfs(Problem, Initial, [Initial], Solution).

solve(Problem, Solution):-
/***************************************************************************/
/* Your code goes here                                                     */
/* You can use the code below as a hint.                                   */
/***************************************************************************/
    
Problem = [Tops, Rights, Boxes, Solutions, sokoban(Sokoban)],
abolish_all_tables,
retractall(top(_,_)),
findall(_, ( member(P, Tops), assert(P) ), _),
retractall(right(_,_)),
findall(_, ( member(P, Rights), assert(P) ), _),
retractall(solution(_)),
findall(_, ( member(P, Solutions), assert(P) ), _),

retractall(initial_state(_,_)),
findall(Box, member(box(Box), Boxes), BoxLocs),
assert(initial_state(sokoban, state(Sokoban, BoxLocs))),
solve_problem(sokoban, Solution).
