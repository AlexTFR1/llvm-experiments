; ModuleID = 'sum.c'
source_filename = "sum.c"
target datalayout = "e-m:w-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc19.13.26129"

; Function Attrs: norecurse nounwind readnone uwtable
define dso_local i32 @sum(i32 %a, i32 %b) local_unnamed_addr #0 {
entry:
  %add = add nsw i32 %b, %a
  ret i32 %add
}

; Function Attrs: norecurse nounwind readnone uwtable
define dso_local i32 @min(i32 %a, i32 %b) local_unnamed_addr #0 {
entry:
  %cmp = icmp slt i32 %a, %b
  %a.b = select i1 %cmp, i32 %a, i32 %b
  ret i32 %a.b
}

attributes #0 = { norecurse nounwind readnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 2}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{!"clang version 7.0.0 (https://github.com/llvm-mirror/clang.git 46f5ec2ba706ffebdab8b77be3fe96070357766b) (https://github.com/llvm-mirror/llvm.git b273503311ade5f98f2879195ed9c5655c3fff1b)"}
