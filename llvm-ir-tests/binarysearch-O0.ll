; ModuleID = 'binarysearch.c'
source_filename = "binarysearch.c"
target datalayout = "e-m:w-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc19.15.26730"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @binarysearch(i32*, i32, i32) #0 {
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32*, align 8
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  store i32 %2, i32* %5, align 4
  store i32 %1, i32* %6, align 4
  store i32* %0, i32** %7, align 8
  store i32 0, i32* %8, align 4
  %11 = load i32, i32* %6, align 4
  %12 = sub nsw i32 %11, 1
  store i32 %12, i32* %9, align 4
  br label %13

; <label>:13:                                     ; preds = %46, %3
  %14 = load i32, i32* %9, align 4
  %15 = load i32, i32* %8, align 4
  %16 = icmp sge i32 %14, %15
  br i1 %16, label %17, label %47

; <label>:17:                                     ; preds = %13
  %18 = load i32, i32* %8, align 4
  %19 = load i32, i32* %9, align 4
  %20 = add nsw i32 %18, %19
  %21 = sdiv i32 %20, 2
  store i32 %21, i32* %10, align 4
  %22 = load i32, i32* %5, align 4
  %23 = load i32*, i32** %7, align 8
  %24 = load i32, i32* %10, align 4
  %25 = zext i32 %24 to i64
  %26 = getelementptr inbounds i32, i32* %23, i64 %25
  %27 = load i32, i32* %26, align 4
  %28 = icmp eq i32 %22, %27
  br i1 %28, label %29, label %31

; <label>:29:                                     ; preds = %17
  %30 = load i32, i32* %10, align 4
  store i32 %30, i32* %4, align 4
  br label %48

; <label>:31:                                     ; preds = %17
  %32 = load i32, i32* %5, align 4
  %33 = load i32*, i32** %7, align 8
  %34 = load i32, i32* %10, align 4
  %35 = zext i32 %34 to i64
  %36 = getelementptr inbounds i32, i32* %33, i64 %35
  %37 = load i32, i32* %36, align 4
  %38 = icmp sgt i32 %32, %37
  br i1 %38, label %39, label %42

; <label>:39:                                     ; preds = %31
  %40 = load i32, i32* %10, align 4
  %41 = add i32 %40, 1
  store i32 %41, i32* %8, align 4
  br label %45

; <label>:42:                                     ; preds = %31
  %43 = load i32, i32* %10, align 4
  %44 = sub i32 %43, 1
  store i32 %44, i32* %9, align 4
  br label %45

; <label>:45:                                     ; preds = %42, %39
  br label %46

; <label>:46:                                     ; preds = %45
  br label %13

; <label>:47:                                     ; preds = %13
  store i32 -1, i32* %4, align 4
  br label %48

; <label>:48:                                     ; preds = %47, %29
  %49 = load i32, i32* %4, align 4
  ret i32 %49
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 2}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{!"clang version 8.0.0 (https://github.com/llvm-mirror/clang.git 5cdd15159a9a43caabb1f32f8fec497ef66318da) (https://github.com/llvm-mirror/llvm.git 500b851fc5b88268b9f09f8505dbd17405742f12)"}
