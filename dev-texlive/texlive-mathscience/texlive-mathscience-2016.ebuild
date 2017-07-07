# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

TEXLIVE_MODULE_CONTENTS="12many SIstyle SIunits alg algorithm2e algorithmicx algorithms amstex apxproof autobreak backnaur begriff binomexp biocon bitpattern bohr boldtensors bosisio bpchem bropd bytefield calculation ccfonts chemarrow chemcompounds chemcono chemexec chemformula chemgreek chemmacros chemnum chemschemex chemstyle clrscode clrscode3e commath complexity computational-complexity concmath concrete conteq cryptocode delim delimset delimseasy diffcoeff digiconfigs drawmatrix drawstack dyntree ebproof econometrics eltex emf endiagram engtlc eqnarray extarrows extpfeil faktor fouridx functan galois gastex gene-logic ghsystem grundgesetze gu hep hepnames hepparticles hepthesis hepunits interval ionumbers isomath karnaugh karnaugh-map karnaughmap logicproof lpform lplfitch lstbayes mathcomp mathpartir matlab-prettifier mattens mgltex mhchem mhequ miller multiobjective mychemistry natded nath nuc nucleardata objectz ot-tableau oubraces perfectcut physics prftree proba prooftrees pseudocode pygmentex rec-thy revquantum ribbonproofs rmathbr sasnrdisplay sciposter sclang-prettifier sesamanuel sfg shuffle simpler-wick simplewick siunitx skmath spalign stanli statex statex2 steinmetz stmaryrd struktex substances subsupscripts susy syllogism sympytexpackage synproof t-angles tablor tensor tex-ewd textopo thmbox turnstile ulqda unitsdef venn xymtex yhmath youngtab ytableau collection-mathscience
"
TEXLIVE_MODULE_DOC_CONTENTS="12many.doc SIstyle.doc SIunits.doc alg.doc algorithm2e.doc algorithmicx.doc algorithms.doc amstex.doc apxproof.doc autobreak.doc backnaur.doc begriff.doc binomexp.doc biocon.doc bitpattern.doc bohr.doc boldtensors.doc bosisio.doc bpchem.doc bropd.doc bytefield.doc calculation.doc ccfonts.doc chemarrow.doc chemcompounds.doc chemcono.doc chemexec.doc chemformula.doc chemgreek.doc chemmacros.doc chemnum.doc chemschemex.doc chemstyle.doc clrscode.doc clrscode3e.doc commath.doc complexity.doc computational-complexity.doc concmath.doc concrete.doc conteq.doc cryptocode.doc delim.doc delimset.doc delimseasy.doc diffcoeff.doc digiconfigs.doc drawmatrix.doc drawstack.doc dyntree.doc ebproof.doc econometrics.doc eltex.doc emf.doc endiagram.doc engtlc.doc eqnarray.doc extarrows.doc extpfeil.doc faktor.doc fouridx.doc functan.doc galois.doc gastex.doc gene-logic.doc ghsystem.doc grundgesetze.doc gu.doc hep.doc hepnames.doc hepparticles.doc hepthesis.doc hepunits.doc interval.doc ionumbers.doc isomath.doc karnaugh.doc karnaugh-map.doc karnaughmap.doc logicproof.doc lpform.doc lplfitch.doc lstbayes.doc mathcomp.doc mathpartir.doc matlab-prettifier.doc mattens.doc mgltex.doc mhchem.doc mhequ.doc miller.doc multiobjective.doc mychemistry.doc natded.doc nath.doc nuc.doc nucleardata.doc objectz.doc ot-tableau.doc oubraces.doc perfectcut.doc physics.doc prftree.doc proba.doc prooftrees.doc pseudocode.doc pygmentex.doc rec-thy.doc revquantum.doc ribbonproofs.doc rmathbr.doc sasnrdisplay.doc sciposter.doc sclang-prettifier.doc sesamanuel.doc sfg.doc shuffle.doc simpler-wick.doc simplewick.doc siunitx.doc skmath.doc spalign.doc stanli.doc statex.doc statex2.doc steinmetz.doc stmaryrd.doc struktex.doc substances.doc subsupscripts.doc susy.doc syllogism.doc sympytexpackage.doc synproof.doc t-angles.doc tablor.doc tensor.doc tex-ewd.doc textopo.doc thmbox.doc turnstile.doc ulqda.doc unitsdef.doc venn.doc xymtex.doc yhmath.doc youngtab.doc ytableau.doc "
TEXLIVE_MODULE_SRC_CONTENTS="12many.source SIstyle.source SIunits.source alg.source algorithms.source apxproof.source autobreak.source backnaur.source binomexp.source bitpattern.source bosisio.source bpchem.source bropd.source bytefield.source calculation.source ccfonts.source chemarrow.source chemcompounds.source chemschemex.source chemstyle.source computational-complexity.source concmath.source conteq.source delim.source delimset.source drawmatrix.source dyntree.source eqnarray.source extpfeil.source faktor.source fouridx.source functan.source galois.source grundgesetze.source ionumbers.source karnaugh-map.source karnaughmap.source logicproof.source lplfitch.source lstbayes.source mathcomp.source mathpartir.source matlab-prettifier.source mattens.source mgltex.source miller.source multiobjective.source nucleardata.source objectz.source proba.source revquantum.source rmathbr.source sclang-prettifier.source sesamanuel.source shuffle.source simplewick.source siunitx.source skmath.source spalign.source steinmetz.source stmaryrd.source struktex.source sympytexpackage.source tensor.source textopo.source thmbox.source turnstile.source ulqda.source unitsdef.source xymtex.source yhmath.source youngtab.source ytableau.source "
inherit  texlive-module
DESCRIPTION="TeXLive Mathematics and science packages"

LICENSE=" BSD GPL-1 GPL-2 GPL-3 LGPL-2 LPPL-1.2 LPPL-1.3 MIT public-domain TeX TeX-other-free "
SLOT="0"
KEYWORDS="alpha amd64 arm ~arm64 ~hppa ia64 ~mips ppc ~ppc64 ~s390 ~sh sparc x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""
DEPEND=">=dev-texlive/texlive-fontsrecommended-2016
>=dev-texlive/texlive-latex-2016
!<dev-texlive/texlive-latexextra-2016
!dev-tex/SIunits
!dev-texlive/texlive-mathextra
!dev-texlive/texlive-science
"
RDEPEND="${DEPEND} dev-texlive/texlive-pstricks
"
TEXLIVE_MODULE_BINSCRIPTS="texmf-dist/scripts/ulqda/ulqda.pl texmf-dist/scripts/pygmentex/pygmentex.py"
