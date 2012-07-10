
/*
 * THIS FILE IS GENERATED FROM pdl.h.PL! Do NOT edit!
 */

#ifndef __PDL_H
#define __PDL_H

#define PDL_DEBUGGING 1

#ifdef PDL_DEBUGGING
extern int pdl_debugging;
#define PDLDEBUG_f(a)		if(pdl_debugging) a
#else
#define PDLDEBUG_f(a)
#endif

typedef struct pdl pdl;


/*****************************************************************************/
/*** This section of .h file generated automatically - don't edit manually ***/

/* Data types/sizes [must be in order of complexity] */

enum pdl_datatypes { PDL_B, PDL_S, PDL_US, PDL_L, PDL_LL, PDL_F, PDL_D };

/* Define the pdl data types */

typedef unsigned char              PDL_Byte;
typedef short              PDL_Short;
typedef unsigned short              PDL_Ushort;
typedef int              PDL_Long;
typedef long              PDL_LongLong;
typedef float              PDL_Float;
typedef double              PDL_Double;


/*****************************************************************************/


#define PDL_U PDL_US
#define PDL_Q PDL_LL




typedef struct badvals {
   double Double;
   double default_Double;
   float Float;
   float default_Float;
   long LongLong;
   long default_LongLong;
   int Long;
   int default_Long;
   unsigned short Ushort;
   unsigned short default_Ushort;
   short Short;
   short default_Short;
   unsigned char Byte;
   unsigned char default_Byte;
} badvals;

/*
   Define the pdl C data structure which maps onto the original PDL
   perl data structure.

   Note: in above pdl.sv is defined as a void pointer to avoid
   having to include perl.h in C code which just needs the pdl
   data.
*/

#define PDL_NDIMS 6  /* Number of dims[] to preallocate */
#define PDL_NCHILDREN 8 /* Number of children ptrs to preallocate */

#define PDL_NTHREADIDS 4 /* Number of different threadids/pdl to preallocate */

/* Constants for pdl.state - not all combinations make sense */
	/* data allocated for this pdl.  this implies that the data
	   is up to date if !PDL_PARENTCHANGED */
#define		PDL_ALLOCATED		0x0001
	/* Parent's data has been altered at some point without changing
	   this pdl. */
#define		PDL_PARENTDATACHANGED	0x0002
	/* Parent's dims or incs or whatever has been altered at some
	   point without changing this pdl. */
#define		PDL_PARENTDIMSCHANGED	0x0004
	/* The physical data representation of the parent has changed,
	   e.g. by copying from its parent to itself as COW.
	   This means that (incs) etc. should be recalculated when used.
	   "parent was allocated" */
#define		PDL_PARENTREPRCHANGED	0x0008

#define PDL_ANYCHANGED (PDL_PARENTDATACHANGED|PDL_PARENTDIMSCHANGED|PDL_PARENTREPRCHANGED)

	/* What kinds of dataflows do we want to track starting from
	   this PDL (B only for transformations which make it possible).
	   All children inherit an 'or' from the parents */
#define		PDL_DATAFLOW_F		0x0010
#define		PDL_DATAFLOW_B		0x0020

#define PDL_DATAFLOW_ANY (PDL_DATAFLOW_F|PDL_DATAFLOW_B)

	/* Was this pdl null originally? */
#define		PDL_NOMYDIMS		0x0040
	/* This means that dims are received through "trans" */
#define 	PDL_MYDIMS_TRANS	0x0080

#define PDL_OPT_VAFFTRANSOK		0x0100

#define PDL_OPT_ANY_OK			(PDL_OPT_VAFFTRANSOK)

#define PDL_HDRCPY				0x0200

#define PDL_BADVAL                              0x0400

#define PDL_TRACEDEBUG                          0x0800

#define PDL_CR_SETDIMSCOND(wtrans,pdl) (((pdl)->state & PDL_MYDIMS_TRANS) \
		&& (pdl)->trans == (pdl_trans *)(wtrans))

#define 	PDL_INPLACE		0x1000

	/* Destroying this now */
#define		PDL_DESTROYING		0x2000

/* You mustn't alter the data pointer nor free this
 * piddle nor use datasv (which is nothing).
 * This means e.g. that the piddle is mmapped from a file
 */
#define		PDL_DONTTOUCHDATA	0x4000

/**************************************************
 *
 * Transformation structure
 */

/*  Only slice and retype to be supported in the near future.
    when FUNCTION is supported, it must be considered how that is going
    to be implemented in terms of COW etc.
 */
typedef enum pdl_transtype { PDL_SLICE, PDL_FUNCTION, PDL_RETYPE }
	pdl_transtype;

/* Transformation flags */
#define 	PDL_TRANS_AFFINE	0x0001

/* Transpdl flags */
#define		PDL_TPDL_VAFFINE_OK	0x01

typedef struct pdl_trans pdl_trans;

typedef struct pdl_transvtable {
	pdl_transtype transtype;
	int flags;
	int nparents;
	int npdls;
	char *per_pdl_flags;
	void (*redodims)(pdl_trans *tr);  /* Only dims and internal trans
		(makes phys) */
	void (*readdata)(pdl_trans *tr);  /* Only data, to "data" ptr  */
	void (*writebackdata)(pdl_trans *tr); /* "data" ptr to parent or granny */
	void (*freetrans)(pdl_trans *tr); /* Free both the contents and it of
					the trans member */
	void (*dump)(pdl_trans *tr); /* Dump this transformation */
				/* Find a virtual parent and make ready
					  for readdata etc. */
	void (*findvparent)(pdl_trans *tr);
	pdl_trans *(*copy)(pdl_trans *tr); /* Full copy */
	void (*can_do)(pdl_trans *tr);
  /* XXX Here should be a "writebackdims" for changed dimensions */
  	int structsize;
	char *name; /* For debuggers, mostly */
	void (*foomethod)(pdl_trans *tr,int i1,int i2,int i3); /* Stupid */
} pdl_transvtable;

/* All trans must start with this */

/* Trans flags */
	/* Single-valued slice i.e. only one image of each parent thing allowed.
	   This is critical in routines that both input from and output to
	   a non-single-valued pdl: updating must occur :(
	 */
#define PDL_ITRANS_REVERSIBLE 0x0001
	/* Whether, if a child is changed, this trans should be destroyed
	   or not */
#define PDL_ITRANS_DO_DATAFLOW_F 0x0002
#define PDL_ITRANS_DO_DATAFLOW_B 0x0004

#define PDL_ITRANS_DO_DATAFLOW_ANY \
		(PDL_ITRANS_DO_DATAFLOW_F|PDL_ITRANS_DO_DATAFLOW_B)

#define PDL_ITRANS_FORFAMILY 0x0008

#define PDL_ITRANS_ISAFFINE 0x1000
#define PDL_ITRANS_VAFFINEVALID 0x2000
#define PDL_ITRANS_NONMUTUAL 0x4000  /* flag for destruction */

/* vparent is the "virtual parent" which is either
 the parent or grandparent or whatever. The trans -structure must store
 both the relationship with our current parent and, if necessary, the
 virtual parent. */

#define PDL_TRANS_START(np) \
	int magicno; \
	short flags; \
	pdl_transvtable *vtable; \
	void (*freeproc)(struct pdl_trans *);  /* Call to free this  \
					(means whether malloced or not) */ \
        pdl *pdls[np]; /* The pdls involved in the transformation */ \
        int bvalflag;  /* required for binary compatability even if WITH_BADVAL=0 */ \
        int has_badvalue; \
        double badvalue; \
	int __datatype

#define PDL_TR_MAGICNO 0x91827364
#define PDL_TR_SETMAGIC(it) it->magicno = PDL_TR_MAGICNO
#define PDL_TR_CLRMAGIC(it) it->magicno = 0x99876134
#ifdef PDL_DEBUGGING
#define PDL_TR_CHKMAGIC(it) if(it->magicno != PDL_TR_MAGICNO) croak("INVALID TRANS MAGIC NO %d %d\n",it,it->magicno); else 0
#else
#define PDL_TR_CHKMAGIC(it)
#endif


struct pdl_trans {
	PDL_TRANS_START(1);
} ;

typedef struct pdl_trans_affine {
	PDL_TRANS_START(2);
/* affine relation to parent */
	PDL_Long *incs; PDL_Long offs;
} pdl_trans_affine;

/* Need to make compatible with pdl_trans_affine */
typedef struct pdl_vaffine {
	PDL_TRANS_START(2);
	PDL_Long *incs; PDL_Long offs;
	int ndims;
	PDL_Long def_incs[PDL_NDIMS];
	pdl *from;
} pdl_vaffine;

#define PDL_VAFFOK(pdl) (pdl->state & PDL_OPT_VAFFTRANSOK)
#define PDL_REPRINC(pdl,which) (PDL_VAFFOK(pdl) ? \
		pdl->vafftrans->incs[which] : pdl->dimincs[which])

#define PDL_REPROFFS(pdl) (PDL_VAFFOK(pdl) ? pdl->vafftrans->offs : 0)

#define PDL_REPRP(pdl) (PDL_VAFFOK(pdl) ? pdl->vafftrans->from->data : pdl->data)

#define PDL_REPRP_TRANS(pdl,flag) ((PDL_VAFFOK(pdl) && \
      (flag & PDL_TPDL_VAFFINE_OK)) ? pdl->vafftrans->from->data : pdl->data)

#define VAFFINE_FLAG_OK(flags,i) ((flags == NULL) ? 1 : (flags[i] & \
				  PDL_TPDL_VAFFINE_OK))

typedef struct pdl_children {
	pdl_trans *trans[PDL_NCHILDREN];
	struct pdl_children *next;
} pdl_children;

/* Family stuff */

typedef struct pdl_family_trans {
	PDL_TRANS_START(2);
	pdl_trans *realtrans;
	pdl *mutateto;
	pdl *mutatefrom;
} pdl_family_trans;

struct pdl_magic;

/* We should try to keep this under 256-foo bytes at all costs */

struct pdl {
#define PDL_MAGICNO 0x24645399
#ifdef PDL_DEBUGGING
#define PDL_CHKMAGIC(it) if(it->magicno != PDL_MAGICNO) croak("INVALID MAGIC NO %d %d\n",it,it->magicno); else 0
#else
#define PDL_CHKMAGIC(it)
#endif
   unsigned long magicno; /* Always stores PDL_MAGICNO as a sanity check */
     /* This is first so most pointer accesses to wrong type are caught */
   int state;        /* What's in this pdl */

   pdl_trans *trans; /* Opaque pointer to internals of transformation from
   			parent */

   pdl_vaffine *vafftrans; /* pointer to vaffine transformation
                              a vafftrans is an optimization that is possible
                              for some types of trans (slice etc)
                              - unused for non-affine transformations
                            */

   void*    sv;      /* (optional) pointer back to original sv.
   			  ALWAYS check for non-null before use.
			  We cannot inc refcnt on this one or we'd
			  never get destroyed */

   void *datasv;	/* Pointer to SV containing data. Refcnt inced */
   void *data;		  /* Null: no data alloced for this one */

   /* bad value stored as double, since get_badvalue returns a double */
   double badvalue;
   int has_badvalue;    /* required by pdlapi.c */

   int nvals;		/* How many values allocated */
   int datatype;
   PDL_Long   *dims;      /* Array of data dimensions */
   PDL_Long   *dimincs;   /* Array of data default increments */
   short    ndims;     /* Number of data dimensions */

   unsigned char *threadids;  /* Starting index of the thread index set n */
   unsigned char nthreadids;

   /* the progenitor, future_me and living_for members
      are unused. They are related to one of Tuomas' ideas about
      pervasive dataflow for PDL and the concept of families that
      he thought up. This was never implemented and Tuomas gave up
      on the idea (and later PDL as a whole). We keep those members
      as a hangover for the moment but they might go at a later time
      -- although that might result in backward compatibility problems
    */

   pdl *progenitor; /* I'm in a mutated family. make_physical_now must
   		       copy me to the new generation. */
   pdl *future_me;  /* I'm the "then" pdl and this is my "now" (or more modern
                       version, anyway */

   pdl_children children;

#define PDL_LIVINGFOR_FAMILY_NEWPROGENITOR   0x0002
#define PDL_LIVINGFOR_FAMILY_NEWMUTATED      0x0004
#define PDL_LIVINGFOR_FAMILY_SRCFORMUTATION  0x0008
   short living_for; /* perl side not referenced; delete me when */

   PDL_Long   def_dims[PDL_NDIMS];   /* Preallocated space for efficiency */
   PDL_Long   def_dimincs[PDL_NDIMS];   /* Preallocated space for efficiency */
   unsigned char def_threadids[PDL_NTHREADIDS];

   struct pdl_magic *magic;

   void *hdrsv; /* "header", settable from Perl */
};


#define PDL_DECL_CHILDLOOP(p) \
		int p##__i; pdl_children *p##__c;
#define PDL_START_CHILDLOOP(p) \
		p##__c = &p->children; \
		do { \
			for(p##__i=0; p##__i<PDL_NCHILDREN; p##__i++) { \
				if(p##__c->trans[p##__i]) {
#define PDL_CHILDLOOP_THISCHILD(p) p##__c->trans[p##__i]
#define PDL_END_CHILDLOOP(p) \
				} \
			} \
			if(!p##__c) break; \
			if(!p##__c->next) break; \
			p##__c=p##__c->next; \
		} while(1);



#define PDLMAX(a,b) ((a) > (b) ? (a) : (b))

#define DECL_RECURSE_GUARD static int __nrec=0;
#define START_RECURSE_GUARD __nrec++; if(__nrec > 1000) {__nrec=0; die("PDL:Internal Error: data structure recursion limit exceeded (max 1000 levels)\n\tThis could mean that you have found an infinite-recursion error in PDL, or\n\tthat you are building data structures with very long dataflow dependency\n\tchains.  You may want to try using sever() to break the dependency.\n");}
#define ABORT_RECURSE_GUARD __nrec=0;
#define END_RECURSE_GUARD __nrec--;

#define PDL_ENSURE_ALLOCATED(it) ((it->state & PDL_ALLOCATED) ||  \
					((pdl_allocdata(it)),1))
#define PDL_ENSURE_VAFFTRANS(it) \
  ( ((!it->vafftrans) || (it->vafftrans->ndims < it->ndims)) && \
    (pdl_vafftrans_alloc(it),1) )

/* __PDL_H */
#endif

