

	.include	doscall.mac
	.include	pspdef.h

	.xdef	keepchk

	.text
	.even

keepchk:
*����
*	4(sp).l	���g�̃������Ǘ��|�C���^
*	8(sp).l	�v���O�����̐擪���环�ʕ�����܂ł̃o�C�g��
*�o��
*	d0.b	�풓���Ă��邩�ǂ���
*		=  0 ... �풓���Ă���
*		= -1 ... �풓���Ă��Ȃ�
*	d1.b	Human68k���璼�ڋN�����ꂽ���ǂ���
*		=  0 ... command.x�Ȃǂ���N��
*		= -1 ... Human68k����N��
*	a0	�������Ǘ��|�C���^
*		d0.b	=  0 ... ���g�̃������Ǘ��|�C���^
*		d0.b	= -1 ... ���t�����풓�v���Z�X�̃������Ǘ��|�C���^
*
MYMP	=	8
IDOFST	=	MYMP+4

	link	a6,#0
	movem.l	d2-d3/a1-a4,-(sp)

	movem.l	MYMP(a6),a0/a4
	lea.l	PSPSIZ(a4),a4
	lea.l	0(a0,a4.l),a1

	movea.l	a1,a2
	moveq.l	#-1,d3
lenlp:
	addq.w	#1,d3
	tst.b	(a2)+
	bne	lenlp

	clr.l	-(sp)
	DOS	_SUPER
	move.l	d0,(sp)

	movea.l	MOTHER(a0),a0
	move.l	MOTHER(a0),d0
	seq.b	d1
	beq	chk0
chklp0:
	movea.l	d0,a0
	move.l	MOTHER(a0),d0
	bne	chklp0

chk0:
	moveq.l	#-1,d2

chklp1:
	cmp.b	KEEPFLAG(a0),d2
	bne	chknx1

	lea.l	0(a0,a4.l),a2
	adda.w	d3,a2

	cmpa.l	MEMEND(a0),a2
	bcc	chknx1

	suba.w	d3,a2
	movea.l	a1,a3
	move.w	d3,d0
cmplp:
	cmpm.b	(a3)+,(a2)+
	dbne	d0,cmplp
	beq	found

chknx1:
	move.l	NEXTMEM(a0),d0
	beq	nfound

	movea.l	d0,a0
	bra	chklp1

found:
	moveq.l	#0,d2

done:
	tst.b	(sp)
	bmi	skip
	DOS	_SUPER
skip:
	addq.l	#4,sp

	tst.b	d2
	seq.b	d0

	movem.l	(sp)+,d2-d3/a1-a4
	unlk	a6

	rts

*
nfound:
	movea.l	MYMP(a6),a0
	bra	done

	.end
