; ModuleID = 'binarysearch.c'
source_filename = "binarysearch.c"
target datalayout = "e-m:w-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc19.15.26730"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @binarysearch(i32*, i32, i32) #0 !dbg !8 {
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32*, align 8
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  store i32 %2, i32* %5, align 4
  call void @llvm.dbg.declare(metadata i32* %5, metadata !13, metadata !DIExpression()), !dbg !14
  store i32 %1, i32* %6, align 4
  call void @llvm.dbg.declare(metadata i32* %6, metadata !15, metadata !DIExpression()), !dbg !16
  store i32* %0, i32** %7, align 8
  call void @llvm.dbg.declare(metadata i32** %7, metadata !17, metadata !DIExpression()), !dbg !18
  call void @llvm.dbg.declare(metadata i32* %8, metadata !19, metadata !DIExpression()), !dbg !20
  store i32 0, i32* %8, align 4, !dbg !20
  call void @llvm.dbg.declare(metadata i32* %9, metadata !21, metadata !DIExpression()), !dbg !22
  %11 = load i32, i32* %6, align 4, !dbg !23
  %12 = sub nsw i32 %11, 1, !dbg !24
  store i32 %12, i32* %9, align 4, !dbg !22
  br label %13, !dbg !25

; <label>:13:                                     ; preds = %46, %3
  %14 = load i32, i32* %9, align 4, !dbg !26
  %15 = load i32, i32* %8, align 4, !dbg !27
  %16 = icmp sge i32 %14, %15, !dbg !28
  br i1 %16, label %17, label %47, !dbg !25

; <label>:17:                                     ; preds = %13
  call void @llvm.dbg.declare(metadata i32* %10, metadata !29, metadata !DIExpression()), !dbg !32
  %18 = load i32, i32* %8, align 4, !dbg !33
  %19 = load i32, i32* %9, align 4, !dbg !34
  %20 = add nsw i32 %18, %19, !dbg !35
  %21 = sdiv i32 %20, 2, !dbg !36
  store i32 %21, i32* %10, align 4, !dbg !32
  %22 = load i32, i32* %5, align 4, !dbg !37
  %23 = load i32*, i32** %7, align 8, !dbg !39
  %24 = load i32, i32* %10, align 4, !dbg !40
  %25 = zext i32 %24 to i64, !dbg !39
  %26 = getelementptr inbounds i32, i32* %23, i64 %25, !dbg !39
  %27 = load i32, i32* %26, align 4, !dbg !39
  %28 = icmp eq i32 %22, %27, !dbg !41
  br i1 %28, label %29, label %31, !dbg !42

; <label>:29:                                     ; preds = %17
  %30 = load i32, i32* %10, align 4, !dbg !43
  store i32 %30, i32* %4, align 4, !dbg !45
  br label %48, !dbg !45

; <label>:31:                                     ; preds = %17
  %32 = load i32, i32* %5, align 4, !dbg !46
  %33 = load i32*, i32** %7, align 8, !dbg !48
  %34 = load i32, i32* %10, align 4, !dbg !49
  %35 = zext i32 %34 to i64, !dbg !48
  %36 = getelementptr inbounds i32, i32* %33, i64 %35, !dbg !48
  %37 = load i32, i32* %36, align 4, !dbg !48
  %38 = icmp sgt i32 %32, %37, !dbg !50
  br i1 %38, label %39, label %42, !dbg !51

; <label>:39:                                     ; preds = %31
  %40 = load i32, i32* %10, align 4, !dbg !52
  %41 = add i32 %40, 1, !dbg !54
  store i32 %41, i32* %8, align 4, !dbg !55
  br label %45, !dbg !56

; <label>:42:                                     ; preds = %31
  %43 = load i32, i32* %10, align 4, !dbg !57
  %44 = sub i32 %43, 1, !dbg !59
  store i32 %44, i32* %9, align 4, !dbg !60
  br label %45

; <label>:45:                                     ; preds = %42, %39
  br label %46

; <label>:46:                                     ; preds = %45
  br label %13, !dbg !25, !llvm.loop !61

; <label>:47:                                     ; preds = %13
  store i32 -1, i32* %4, align 4, !dbg !63
  br label %48, !dbg !63

; <label>:48:                                     ; preds = %47, %29
  %49 = load i32, i32* %4, align 4, !dbg !64
  ret i32 %49, !dbg !64
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5, !6}
!llvm.ident = !{!7}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 8.0.0 (https://github.com/llvm-mirror/clang.git 5cdd15159a9a43caabb1f32f8fec497ef66318da) (https://github.com/llvm-mirror/llvm.git 500b851fc5b88268b9f09f8505dbd17405742f12)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, nameTableKind: None)
!1 = !DIFile(filename: "binarysearch.c", directory: "C:\5CWork\5CDev\5Cllvm\5Cllvm-experiments\5Cllvm-ir-tests")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 2}
!6 = !{i32 7, !"PIC Level", i32 2}
!7 = !{!"clang version 8.0.0 (https://github.com/llvm-mirror/clang.git 5cdd15159a9a43caabb1f32f8fec497ef66318da) (https://github.com/llvm-mirror/llvm.git 500b851fc5b88268b9f09f8505dbd17405742f12)"}
!8 = distinct !DISubprogram(name: "binarysearch", scope: !1, file: !1, line: 12, type: !9, isLocal: false, isDefinition: true, scopeLine: 12, flags: DIFlagPrototyped, isOptimized: false, unit: !0, retainedNodes: !2)
!9 = !DISubroutineType(types: !10)
!10 = !{!11, !12, !11, !11}
!11 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!12 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !11, size: 64)
!13 = !DILocalVariable(name: "tosearch", arg: 3, scope: !8, file: !1, line: 12, type: !11)
!14 = !DILocation(line: 12, column: 47, scope: !8)
!15 = !DILocalVariable(name: "length", arg: 2, scope: !8, file: !1, line: 12, type: !11)
!16 = !DILocation(line: 12, column: 35, scope: !8)
!17 = !DILocalVariable(name: "array", arg: 1, scope: !8, file: !1, line: 12, type: !12)
!18 = !DILocation(line: 12, column: 22, scope: !8)
!19 = !DILocalVariable(name: "L", scope: !8, file: !1, line: 13, type: !11)
!20 = !DILocation(line: 13, column: 9, scope: !8)
!21 = !DILocalVariable(name: "R", scope: !8, file: !1, line: 14, type: !11)
!22 = !DILocation(line: 14, column: 9, scope: !8)
!23 = !DILocation(line: 14, column: 13, scope: !8)
!24 = !DILocation(line: 14, column: 20, scope: !8)
!25 = !DILocation(line: 16, column: 5, scope: !8)
!26 = !DILocation(line: 16, column: 12, scope: !8)
!27 = !DILocation(line: 16, column: 17, scope: !8)
!28 = !DILocation(line: 16, column: 14, scope: !8)
!29 = !DILocalVariable(name: "middle", scope: !30, file: !1, line: 17, type: !31)
!30 = distinct !DILexicalBlock(scope: !8, file: !1, line: 16, column: 20)
!31 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!32 = !DILocation(line: 17, column: 18, scope: !30)
!33 = !DILocation(line: 17, column: 28, scope: !30)
!34 = !DILocation(line: 17, column: 32, scope: !30)
!35 = !DILocation(line: 17, column: 30, scope: !30)
!36 = !DILocation(line: 17, column: 35, scope: !30)
!37 = !DILocation(line: 18, column: 13, scope: !38)
!38 = distinct !DILexicalBlock(scope: !30, file: !1, line: 18, column: 13)
!39 = !DILocation(line: 18, column: 25, scope: !38)
!40 = !DILocation(line: 18, column: 31, scope: !38)
!41 = !DILocation(line: 18, column: 22, scope: !38)
!42 = !DILocation(line: 18, column: 13, scope: !30)
!43 = !DILocation(line: 19, column: 20, scope: !44)
!44 = distinct !DILexicalBlock(scope: !38, file: !1, line: 18, column: 40)
!45 = !DILocation(line: 19, column: 13, scope: !44)
!46 = !DILocation(line: 21, column: 18, scope: !47)
!47 = distinct !DILexicalBlock(scope: !38, file: !1, line: 21, column: 18)
!48 = !DILocation(line: 21, column: 29, scope: !47)
!49 = !DILocation(line: 21, column: 35, scope: !47)
!50 = !DILocation(line: 21, column: 27, scope: !47)
!51 = !DILocation(line: 21, column: 18, scope: !38)
!52 = !DILocation(line: 22, column: 17, scope: !53)
!53 = distinct !DILexicalBlock(scope: !47, file: !1, line: 21, column: 44)
!54 = !DILocation(line: 22, column: 24, scope: !53)
!55 = !DILocation(line: 22, column: 15, scope: !53)
!56 = !DILocation(line: 23, column: 9, scope: !53)
!57 = !DILocation(line: 24, column: 17, scope: !58)
!58 = distinct !DILexicalBlock(scope: !47, file: !1, line: 23, column: 16)
!59 = !DILocation(line: 24, column: 24, scope: !58)
!60 = !DILocation(line: 24, column: 15, scope: !58)
!61 = distinct !{!61, !25, !62}
!62 = !DILocation(line: 26, column: 5, scope: !8)
!63 = !DILocation(line: 27, column: 5, scope: !8)
!64 = !DILocation(line: 28, column: 1, scope: !8)
