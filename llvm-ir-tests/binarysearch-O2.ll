; ModuleID = 'binarysearch.c'
source_filename = "binarysearch.c"
target datalayout = "e-m:w-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc19.15.26730"

; Function Attrs: norecurse nounwind readonly uwtable
define dso_local i32 @binarysearch(i32* nocapture readonly, i32, i32) local_unnamed_addr #0 {
  %4 = icmp slt i32 %1, 1
  br i1 %4, label %23, label %5

; <label>:5:                                      ; preds = %3
  %6 = add nsw i32 %1, -1
  br label %7

; <label>:7:                                      ; preds = %5, %16
  %8 = phi i32 [ %21, %16 ], [ %6, %5 ]
  %9 = phi i32 [ %20, %16 ], [ 0, %5 ]
  %10 = add nsw i32 %8, %9
  %11 = sdiv i32 %10, 2
  %12 = zext i32 %11 to i64
  %13 = getelementptr inbounds i32, i32* %0, i64 %12
  %14 = load i32, i32* %13, align 4, !tbaa !3
  %15 = icmp eq i32 %14, %2
  br i1 %15, label %23, label %16

; <label>:16:                                     ; preds = %7
  %17 = icmp slt i32 %14, %2
  %18 = add nsw i32 %11, 1
  %19 = add nsw i32 %11, -1
  %20 = select i1 %17, i32 %18, i32 %9
  %21 = select i1 %17, i32 %8, i32 %19
  %22 = icmp slt i32 %21, %20
  br i1 %22, label %23, label %7

; <label>:23:                                     ; preds = %16, %7, %3
  %24 = phi i32 [ -1, %3 ], [ %11, %7 ], [ -1, %16 ]
  ret i32 %24
}

attributes #0 = { norecurse nounwind readonly uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 2}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{!"clang version 8.0.0 (https://github.com/llvm-mirror/clang.git 5cdd15159a9a43caabb1f32f8fec497ef66318da) (https://github.com/llvm-mirror/llvm.git 500b851fc5b88268b9f09f8505dbd17405742f12)"}
!3 = !{!4, !4, i64 0}
!4 = !{!"int", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C/C++ TBAA"}
