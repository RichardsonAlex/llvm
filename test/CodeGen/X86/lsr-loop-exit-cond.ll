; RUN: llc -mtriple=x86_64-darwin -mcpu=generic < %s | FileCheck %s
; RUN: llc -mtriple=x86_64-darwin -mcpu=atom < %s | FileCheck -check-prefix=ATOM %s

; CHECK-LABEL: t:
; CHECK: decq
; CHECK-NEXT: movl (%r9,%rax,4), %eax
; CHECK-NEXT: jne

; ATOM-LABEL: t:
; ATOM: movl (%r9,%r{{.+}},4), %eax
; ATOM-NEXT: decq
; ATOM-NEXT: jne

@Te0 = external global [256 x i32]		; <[256 x i32]*> [#uses=5]
@Te1 = external global [256 x i32]		; <[256 x i32]*> [#uses=4]
@Te3 = external global [256 x i32]		; <[256 x i32]*> [#uses=2]

define void @t(i8* nocapture %in, i8* nocapture %out, i32* nocapture %rk, i32 %r) nounwind {
entry:
	%0 = load i32* %rk, align 4		; <i32> [#uses=1]
	%1 = getelementptr i32* %rk, i64 1		; <i32*> [#uses=1]
	%2 = load i32* %1, align 4		; <i32> [#uses=1]
	%tmp15 = add i32 %r, -1		; <i32> [#uses=1]
	%tmp.16 = zext i32 %tmp15 to i64		; <i64> [#uses=2]
	br label %bb

bb:		; preds = %bb1, %entry
	%indvar = phi i64 [ 0, %entry ], [ %indvar.next, %bb1 ]		; <i64> [#uses=3]
	%s1.0 = phi i32 [ %2, %entry ], [ %56, %bb1 ]		; <i32> [#uses=2]
	%s0.0 = phi i32 [ %0, %entry ], [ %43, %bb1 ]		; <i32> [#uses=2]
	%tmp18 = shl i64 %indvar, 4		; <i64> [#uses=4]
	%rk26 = bitcast i32* %rk to i8*		; <i8*> [#uses=6]
	%3 = lshr i32 %s0.0, 24		; <i32> [#uses=1]
	%4 = zext i32 %3 to i64		; <i64> [#uses=1]
	%5 = getelementptr [256 x i32]* @Te0, i64 0, i64 %4		; <i32*> [#uses=1]
	%6 = load i32* %5, align 4		; <i32> [#uses=1]
	%7 = lshr i32 %s1.0, 16		; <i32> [#uses=1]
	%8 = and i32 %7, 255		; <i32> [#uses=1]
	%9 = zext i32 %8 to i64		; <i64> [#uses=1]
	%10 = getelementptr [256 x i32]* @Te1, i64 0, i64 %9		; <i32*> [#uses=1]
	%11 = load i32* %10, align 4		; <i32> [#uses=1]
	%ctg2.sum2728 = or i64 %tmp18, 8		; <i64> [#uses=1]
	%12 = getelementptr i8* %rk26, i64 %ctg2.sum2728		; <i8*> [#uses=1]
	%13 = bitcast i8* %12 to i32*		; <i32*> [#uses=1]
	%14 = load i32* %13, align 4		; <i32> [#uses=1]
	%15 = xor i32 %11, %6		; <i32> [#uses=1]
	%16 = xor i32 %15, %14		; <i32> [#uses=3]
	%17 = lshr i32 %s1.0, 24		; <i32> [#uses=1]
	%18 = zext i32 %17 to i64		; <i64> [#uses=1]
	%19 = getelementptr [256 x i32]* @Te0, i64 0, i64 %18		; <i32*> [#uses=1]
	%20 = load i32* %19, align 4		; <i32> [#uses=1]
	%21 = and i32 %s0.0, 255		; <i32> [#uses=1]
	%22 = zext i32 %21 to i64		; <i64> [#uses=1]
	%23 = getelementptr [256 x i32]* @Te3, i64 0, i64 %22		; <i32*> [#uses=1]
	%24 = load i32* %23, align 4		; <i32> [#uses=1]
	%ctg2.sum2930 = or i64 %tmp18, 12		; <i64> [#uses=1]
	%25 = getelementptr i8* %rk26, i64 %ctg2.sum2930		; <i8*> [#uses=1]
	%26 = bitcast i8* %25 to i32*		; <i32*> [#uses=1]
	%27 = load i32* %26, align 4		; <i32> [#uses=1]
	%28 = xor i32 %24, %20		; <i32> [#uses=1]
	%29 = xor i32 %28, %27		; <i32> [#uses=4]
	%30 = lshr i32 %16, 24		; <i32> [#uses=1]
	%31 = zext i32 %30 to i64		; <i64> [#uses=1]
	%32 = getelementptr [256 x i32]* @Te0, i64 0, i64 %31		; <i32*> [#uses=1]
	%33 = load i32* %32, align 4		; <i32> [#uses=2]
	%exitcond = icmp eq i64 %indvar, %tmp.16		; <i1> [#uses=1]
	br i1 %exitcond, label %bb2, label %bb1

bb1:		; preds = %bb
	%ctg2.sum31 = add i64 %tmp18, 16		; <i64> [#uses=1]
	%34 = getelementptr i8* %rk26, i64 %ctg2.sum31		; <i8*> [#uses=1]
	%35 = bitcast i8* %34 to i32*		; <i32*> [#uses=1]
	%36 = lshr i32 %29, 16		; <i32> [#uses=1]
	%37 = and i32 %36, 255		; <i32> [#uses=1]
	%38 = zext i32 %37 to i64		; <i64> [#uses=1]
	%39 = getelementptr [256 x i32]* @Te1, i64 0, i64 %38		; <i32*> [#uses=1]
	%40 = load i32* %39, align 4		; <i32> [#uses=1]
	%41 = load i32* %35, align 4		; <i32> [#uses=1]
	%42 = xor i32 %40, %33		; <i32> [#uses=1]
	%43 = xor i32 %42, %41		; <i32> [#uses=1]
	%44 = lshr i32 %29, 24		; <i32> [#uses=1]
	%45 = zext i32 %44 to i64		; <i64> [#uses=1]
	%46 = getelementptr [256 x i32]* @Te0, i64 0, i64 %45		; <i32*> [#uses=1]
	%47 = load i32* %46, align 4		; <i32> [#uses=1]
	%48 = and i32 %16, 255		; <i32> [#uses=1]
	%49 = zext i32 %48 to i64		; <i64> [#uses=1]
	%50 = getelementptr [256 x i32]* @Te3, i64 0, i64 %49		; <i32*> [#uses=1]
	%51 = load i32* %50, align 4		; <i32> [#uses=1]
	%ctg2.sum32 = add i64 %tmp18, 20		; <i64> [#uses=1]
	%52 = getelementptr i8* %rk26, i64 %ctg2.sum32		; <i8*> [#uses=1]
	%53 = bitcast i8* %52 to i32*		; <i32*> [#uses=1]
	%54 = load i32* %53, align 4		; <i32> [#uses=1]
	%55 = xor i32 %51, %47		; <i32> [#uses=1]
	%56 = xor i32 %55, %54		; <i32> [#uses=1]
	%indvar.next = add i64 %indvar, 1		; <i64> [#uses=1]
	br label %bb

bb2:		; preds = %bb
	%tmp10 = shl i64 %tmp.16, 4		; <i64> [#uses=2]
	%ctg2.sum = add i64 %tmp10, 16		; <i64> [#uses=1]
	%tmp1213 = getelementptr i8* %rk26, i64 %ctg2.sum		; <i8*> [#uses=1]
	%57 = bitcast i8* %tmp1213 to i32*		; <i32*> [#uses=1]
	%58 = and i32 %33, -16777216		; <i32> [#uses=1]
	%59 = lshr i32 %29, 16		; <i32> [#uses=1]
	%60 = and i32 %59, 255		; <i32> [#uses=1]
	%61 = zext i32 %60 to i64		; <i64> [#uses=1]
	%62 = getelementptr [256 x i32]* @Te1, i64 0, i64 %61		; <i32*> [#uses=1]
	%63 = load i32* %62, align 4		; <i32> [#uses=1]
	%64 = and i32 %63, 16711680		; <i32> [#uses=1]
	%65 = or i32 %64, %58		; <i32> [#uses=1]
	%66 = load i32* %57, align 4		; <i32> [#uses=1]
	%67 = xor i32 %65, %66		; <i32> [#uses=2]
	%68 = lshr i32 %29, 8		; <i32> [#uses=1]
	%69 = zext i32 %68 to i64		; <i64> [#uses=1]
	%70 = getelementptr [256 x i32]* @Te0, i64 0, i64 %69		; <i32*> [#uses=1]
	%71 = load i32* %70, align 4		; <i32> [#uses=1]
	%72 = and i32 %71, -16777216		; <i32> [#uses=1]
	%73 = and i32 %16, 255		; <i32> [#uses=1]
	%74 = zext i32 %73 to i64		; <i64> [#uses=1]
	%75 = getelementptr [256 x i32]* @Te1, i64 0, i64 %74		; <i32*> [#uses=1]
	%76 = load i32* %75, align 4		; <i32> [#uses=1]
	%77 = and i32 %76, 16711680		; <i32> [#uses=1]
	%78 = or i32 %77, %72		; <i32> [#uses=1]
	%ctg2.sum25 = add i64 %tmp10, 20		; <i64> [#uses=1]
	%79 = getelementptr i8* %rk26, i64 %ctg2.sum25		; <i8*> [#uses=1]
	%80 = bitcast i8* %79 to i32*		; <i32*> [#uses=1]
	%81 = load i32* %80, align 4		; <i32> [#uses=1]
	%82 = xor i32 %78, %81		; <i32> [#uses=2]
	%83 = lshr i32 %67, 24		; <i32> [#uses=1]
	%84 = trunc i32 %83 to i8		; <i8> [#uses=1]
	store i8 %84, i8* %out, align 1
	%85 = lshr i32 %67, 16		; <i32> [#uses=1]
	%86 = trunc i32 %85 to i8		; <i8> [#uses=1]
	%87 = getelementptr i8* %out, i64 1		; <i8*> [#uses=1]
	store i8 %86, i8* %87, align 1
	%88 = getelementptr i8* %out, i64 4		; <i8*> [#uses=1]
	%89 = lshr i32 %82, 24		; <i32> [#uses=1]
	%90 = trunc i32 %89 to i8		; <i8> [#uses=1]
	store i8 %90, i8* %88, align 1
	%91 = lshr i32 %82, 16		; <i32> [#uses=1]
	%92 = trunc i32 %91 to i8		; <i8> [#uses=1]
	%93 = getelementptr i8* %out, i64 5		; <i8*> [#uses=1]
	store i8 %92, i8* %93, align 1
	ret void
}

; Check that DAGCombiner doesn't mess up the IV update when the exiting value
; is equal to the stride.
; It must not fold (cmp (add iv, 1), 1) --> (cmp iv, 0).

; CHECK-LABEL: f:
; CHECK: %for.body
; CHECK: incl [[IV:%e..]]
; CHECK: cmpl $1, [[IV]]
; CHECK: jne
; CHECK: ret

; ATOM-LABEL: f:
; ATOM: %for.body
; ATOM: incl [[IV:%e..]]
; ATOM: cmpl $1, [[IV]]
; ATOM: jne
; ATOM: ret

define i32 @f(i32 %i, i32* nocapture %a) nounwind uwtable readonly ssp {
entry:
  %cmp4 = icmp eq i32 %i, 1
  br i1 %cmp4, label %for.end, label %for.body.lr.ph

for.body.lr.ph:                                   ; preds = %entry
  %0 = sext i32 %i to i64
  br label %for.body

for.body:                                         ; preds = %for.body.lr.ph, %for.body
  %indvars.iv = phi i64 [ %0, %for.body.lr.ph ], [ %indvars.iv.next, %for.body ]
  %bi.06 = phi i32 [ 0, %for.body.lr.ph ], [ %i.addr.0.bi.0, %for.body ]
  %b.05 = phi i32 [ 0, %for.body.lr.ph ], [ %.b.0, %for.body ]
  %arrayidx = getelementptr inbounds i32* %a, i64 %indvars.iv
  %1 = load i32* %arrayidx, align 4
  %cmp1 = icmp ugt i32 %1, %b.05
  %.b.0 = select i1 %cmp1, i32 %1, i32 %b.05
  %2 = trunc i64 %indvars.iv to i32
  %i.addr.0.bi.0 = select i1 %cmp1, i32 %2, i32 %bi.06
  %indvars.iv.next = add i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, 1
  br i1 %exitcond, label %for.end, label %for.body

for.end:                                          ; preds = %for.body, %entry
  %bi.0.lcssa = phi i32 [ 0, %entry ], [ %i.addr.0.bi.0, %for.body ]
  ret i32 %bi.0.lcssa
}
