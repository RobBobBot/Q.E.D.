import 'package:flutter/material.dart';
import 'package:qed/redux/app_actions.dart';
import 'package:qed/redux/app_reducer.dart';
import 'package:qed/redux/app_state.dart';

AppState appReducer(AppState state, dynamic action) {
  if (action is AddProblemAction) {
    state.problems[action.problem.id] = action.problem;
  }
  if (action is AddContestAction) {
    state.contests[action.contest.id] = action.contest;
  }
  return state;
}
