// Global settings

#let rem = 11.3pt

#show link: set text(fill: rgb("004466"))

#set text(
  font: "Libertinus Serif",
  size: rem,
)

#set list(indent: 0.5em)
#set block(spacing: 0.65em)
#set par(spacing: 0.65em)

#set page(
  paper: "us-letter",
  margin: (x: .5in, y: .65in),
)

// Building blocks

#let error-text(msg) = text(fill: red, "⟨" + msg + "⟩")

#let redacted = error-text("Redacted")
#let blackout(n) = text(tracking: -0.05em, range(n).map(i => "█").join())

#let linkurl(url) = link(url, url)

#let contact-item(key, value) = [*#key* #h(1pt) #value #h(rem, weak: true)]

#let main-title(title) = text(size: 2 * rem, title)

#let section-title(title) = [
  #set block(spacing: 5pt)
  #line(length: 100%, stroke: .75pt + luma(221))
  #text(size: 1.36 * rem, title)
  #v(.5em)
]

#let entry(content) = [
  #content
  #v(.9em)
]

#let entry-heading(content) = [
  #content
  #v(1pt)
]

#let split(left, right) = grid(
  columns: (auto, 1fr),
  column-gutter: 3pt,
  align: (alignment.left, alignment.right),
  left, right
)

// Secrets

#let redact = true
#let secrets_var = (:)

#if not redact {
  import "secrets.typ": secrets
  secrets_var = secrets
}

#let secret(name, default: redacted) = secrets_var.at(name, default: default)
#let with-secret(name, f, default: redacted) = if name in secrets_var { f(secrets_var.at(name)) } else { default }

// Convenience functions

#let email-link(email) = link("mailto:" + email)[#email]
#let github-link(username) = link("https://github.com/" + username)[#username]
#let linkedin-link(username) = link("https://www.linkedin.com/in/" + username)[linkedin.com/in/#username]

#let position(
  title,
  from: error-text("unknown start date"),
  to: [Present],
  location: error-text("unknown location")
) = split(emph(title), emph[#location #h(2pt) *‧* #h(2pt) #from -- #to])

#let experience(
  affiliation,
  positions,
  body
) = entry[
  #entry-heading[
    #split[*#affiliation,*][#if type(positions) == array {
      positions.join()
    } else {
      positions
    }]
  ]
  #body
]

#let project(
  name,
  url,
  body
) = entry[
  #entry-heading(split(strong(name), emph(linkurl(url))))
  #body
]

#let reference(
  name,
  email,
  body
) = entry[
  #entry-heading(strong(name), emph(email-link(email)))
  #body
]

// Content

#main-title[#secret("legal-name", default:
  [#blackout(9) #text(size: 1.36 * rem, [a.k.a. _"daylily"_])]
)]

#entry[
  #contact-item[Email][#email-link("i@dayli.ly")]
  #contact-item[Phone][#secret("phone-number", default: blackout(10))]
  #contact-item[GitHub][#github-link("re-xyr")]
  #contact-item[LinkedIn][#with-secret("linkedin-profile", linkedin-link, default: blackout(14))]
]

#section-title[Education]

#experience(
  [Carnegie Mellon University],
  position(
    [B.S. in Computer Science (GPA 4.00)],
    from: [Aug 2023], to: [Dec 2026],
    location: [Pittsburgh, PA]
  )
)[
  - Relevant coursework: Computer Systems, Intro to AI, Functional Programming, Discrete Math, Theoretical CS, Linear Algebra, Vector Calculus
]

#section-title[Work Experience]

#experience(
  [Google],
  (
    position(
      [STEP Intern (Google Learning)],
      from: [May 2024], to: [Aug 2024],
      location: [New York, NY]
    ),
  ),
)[
  - Implemented a new feature in the Google Search math solver, and launched a live experiment
  - Prototyped and demoed a feature integrating generative AI with Google Search math solver
  - Engaged extensively with the Google Search technology stack, writing code in C++, Java, TypeScript, HTML, CSS
]

#experience(
  [MLabs Ltd.],
  position(
    [Software Consultant (Haskell & Plutus)],
    from: [Oct 2021], to: [May 2023],
    location: [London, UK (Remote)]
  )
)[
  - Developed an eDSL in Haskell for writing #link("https://cardano.org/")[Cardano blockchain] transaction specifications
  - Implemented a unit and property testing library for the Plutus smart contract language
]

#experience(
  [Taichi Graphics],
  position(
    [Intern Compiler Engineer],
    from: [Nov 2021], to: [Mar 2023],
    location: [Beijing, China]
  )
)[
  - Worked on the #link("https://github.com/taichi-dev/taichi")[Taichi compiler], a Python dialect focusing on efficient parallel computation
  - Proposed and implemented a unified, coherent type system to remove reliance on ad-hoc validation logic
  - Refactored several compiler passes and added short-circuiting semantics to the language
]

#experience(
  [Chinese Academy of Sciences],
  position(
    [Intern Research Engineer (PLCT Lab)],
    from: [Oct 2020], to: [Oct 2021],
    location: [Beijing, China]
  )
)[
  - Core contributor to the open source HoTT proof assistant #link("https://github.com/aya-prover/aya-dev")[Aya Prover], with 260 stars on GitHub
  - Implemented core components including module/variable resolution and typechecking
]

#section-title[Personal Projects]

#project([cleff], "https://github.com/re-xyr/cleff")[
  - Efficient and versatile effect handlers in Haskell, 2-5x performance gain compared to mainstream libraries
  - Presented at #link("https://icfp22.sigplan.org/home/hope-2022")[the HOPE workshop at ACM ICFP 2022;] project gained 100+ stars on GitHub
]

#project([aqn], "https://github.com/re-xyr/aqn")[
  - Efficient typechecking and elaboration algorithm of dependent types, written in Haskell
]

#project([WhoJudge], "https://github.com/t532-old/whojudge")[
  - Online judge platform for competitive programming written in TypeScript
  - Implemented as a Vue.js single-page application that communicated with the backend via a GraphQL API
]

#section-title[Skills]

#entry[
  - *Programming languages:* Haskell, TypeScript, HTML/CSS, Java, Kotlin, C/C++, Rust, Python, Scala, LaTeX
  - *Technologies:* Functional programming, Compiler frontend, Type systems, Frontend & Backend web development
  - *Languages:* English: fluent, Mandarin: native
]
