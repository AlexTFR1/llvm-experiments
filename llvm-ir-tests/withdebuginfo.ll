; ModuleID = 'withdebuginfo.c'
source_filename = "withdebuginfo.c"
target datalayout = "e-m:w-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc19.14.26433"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @function1(i32, double) #0 !dbg !10 {
  %3 = alloca double, align 8
  %4 = alloca i32, align 4
  store double %1, double* %3, align 8
  call void @llvm.dbg.declare(metadata double* %3, metadata !14, metadata !DIExpression()), !dbg !15
  store i32 %0, i32* %4, align 4
  call void @llvm.dbg.declare(metadata i32* %4, metadata !16, metadata !DIExpression()), !dbg !17
  %5 = call i32 @function2(i32 10, double 1.200000e+01), !dbg !18
  ret i32 %5, !dbg !19
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @function2(i32, double) #0 !dbg !20 {
  %3 = alloca double, align 8
  %4 = alloca i32, align 4
  store double %1, double* %3, align 8
  call void @llvm.dbg.declare(metadata double* %3, metadata !21, metadata !DIExpression()), !dbg !22
  store i32 %0, i32* %4, align 4
  call void @llvm.dbg.declare(metadata i32* %4, metadata !23, metadata !DIExpression()), !dbg !24
  %5 = load i32, i32* %4, align 4, !dbg !25
  %6 = load double, double* %3, align 8, !dbg !26
  %7 = load i32, i32* %4, align 4, !dbg !27
  %8 = call i32 @function1(i32 %7, double %6), !dbg !28
  %9 = add nsw i32 %5, %8, !dbg !29
  ret i32 %9, !dbg !30
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !31 {
  %1 = alloca i32, align 4
  %2 = alloca double, align 8
  store i32 0, i32* %1, align 4
  call void @llvm.dbg.declare(metadata double* %2, metadata !34, metadata !DIExpression()), !dbg !35
  store double 1.200000e+02, double* %2, align 8, !dbg !35
  %3 = load double, double* %2, align 8, !dbg !36
  %4 = fptosi double %3 to i32, !dbg !36
  %5 = call i32 @function2(i32 %4, double 1.200000e+01), !dbg !37
  ret i32 %5, !dbg !38
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!5, !6, !7, !8}
!llvm.ident = !{!9}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 7.0.0 (https://github.com/llvm-mirror/clang.git a7a88118684e7ea75ae229b1ae9b2ac31c7d5fcc) (https://github.com/llvm-mirror/llvm.git b2970fad9bfbb6801273b8bec1a971aae6370c6a)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3)
!1 = !DIFile(filename: "withdebuginfo.c", directory: "C:\5CUsers\5Cpsamolysov\5CDev\5Cllvm\5Cllvm-experiments\5Cllvm-ir-first-step")
!2 = !{}
!3 = !{!4}
!4 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!5 = !{i32 2, !"Dwarf Version", i32 4}
!6 = !{i32 2, !"Debug Info Version", i32 3}
!7 = !{i32 1, !"wchar_size", i32 2}
!8 = !{i32 7, !"PIC Level", i32 2}
!9 = !{!"clang version 7.0.0 (https://github.com/llvm-mirror/clang.git a7a88118684e7ea75ae229b1ae9b2ac31c7d5fcc) (https://github.com/llvm-mirror/llvm.git b2970fad9bfbb6801273b8bec1a971aae6370c6a)"}
!10 = distinct !DISubprogram(name: "function1", scope: !1, file: !1, line: 4, type: !11, isLocal: false, isDefinition: true, scopeLine: 4, flags: DIFlagPrototyped, isOptimized: false, unit: !0, retainedNodes: !2)
!11 = !DISubroutineType(types: !12)
!12 = !{!13, !13, !4}
!13 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!14 = !DILocalVariable(name: "b", arg: 2, scope: !10, file: !1, line: 4, type: !4)
!15 = !DILocation(line: 4, column: 29, scope: !10)
!16 = !DILocalVariable(name: "a", arg: 1, scope: !10, file: !1, line: 4, type: !13)
!17 = !DILocation(line: 4, column: 19, scope: !10)
!18 = !DILocation(line: 5, column: 11, scope: !10)
!19 = !DILocation(line: 5, column: 4, scope: !10)
!20 = distinct !DISubprogram(name: "function2", scope: !1, file: !1, line: 8, type: !11, isLocal: false, isDefinition: true, scopeLine: 8, flags: DIFlagPrototyped, isOptimized: false, unit: !0, retainedNodes: !2)
!21 = !DILocalVariable(name: "b", arg: 2, scope: !20, file: !1, line: 8, type: !4)
!22 = !DILocation(line: 8, column: 29, scope: !20)
!23 = !DILocalVariable(name: "a", arg: 1, scope: !20, file: !1, line: 8, type: !13)
!24 = !DILocation(line: 8, column: 19, scope: !20)
!25 = !DILocation(line: 9, column: 12, scope: !20)
!26 = !DILocation(line: 9, column: 29, scope: !20)
!27 = !DILocation(line: 9, column: 26, scope: !20)
!28 = !DILocation(line: 9, column: 16, scope: !20)
!29 = !DILocation(line: 9, column: 14, scope: !20)
!30 = !DILocation(line: 9, column: 5, scope: !20)
!31 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 12, type: !32, isLocal: false, isDefinition: true, scopeLine: 12, isOptimized: false, unit: !0, retainedNodes: !2)
!32 = !DISubroutineType(types: !33)
!33 = !{!13}
!34 = !DILocalVariable(name: "i", scope: !31, file: !1, line: 13, type: !4)
!35 = !DILocation(line: 13, column: 12, scope: !31)
!36 = !DILocation(line: 14, column: 22, scope: !31)
!37 = !DILocation(line: 14, column: 12, scope: !31)
!38 = !DILocation(line: 14, column: 5, scope: !31)
