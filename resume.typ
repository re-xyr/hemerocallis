// Secrets

#let redact = true
#let secrets_var = (:)

#if not redact {
  import "secrets.typ": secrets
  secrets_var = secrets
}

#let error-text(msg) = text(fill: red, "⟨" + msg + "⟩")
#let redacted = error-text("Redacted")

#let secret(name, default: redacted) = secrets_var.at(name, default: default)
#let with-secret(name, f, default: redacted) = if name in secrets_var { f(secrets_var.at(name)) } else { default }

// Overall typography

#let rem = 11pt

#show link: set text(fill: rgb("004466"))
#set text(
  font: "Libertinus Serif",
  size: rem,
)

#set block(spacing: 0.65em)
#set par(spacing: 0.65em)
#set list(indent: 0.5em)
#set page(paper: "us-letter", margin: .47in)

// Building blocks

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
  left, right,
)

// Convenience functions

#let email-link(email) = link("mailto:" + email)[#email]
#let github-link(username) = link("https://github.com/" + username)[#username]
#let linkedin-link(username) = link("https://www.linkedin.com/in/" + username)[linkedin.com/in/#username]

#let position(
  title,
  from: error-text("unknown start date"),
  to: [Present],
  location: error-text("unknown location"),
) = split(emph(title), emph[#location #h(2pt) *‧* #h(2pt) #from -- #to])

#let experience(affiliation, positions, body) = entry[
  #entry-heading(split(
    [*#affiliation,*],
    if type(positions) == array { positions.join() } else { positions },
  ))
  #body
]

#let project(name, url, body) = entry[
  #entry-heading(split(
    strong(name),
    emph(if url != none {
      linkurl(url)
    } else {
      text("(WIP)", luma(100))
    }),
  ))
  #body
]

#let reference(name, email, body) = entry[
  #entry-heading(strong(name), emph(email-link(email)))
  #body
]

// Content

#main-title[#secret("legal-name", default: [#blackout(9) #text(size: 1.36 * rem, [a.k.a. _"daylily"_])])]

#entry[
  #contact-item[Email][#email-link("i@dayli.ly")]
  #contact-item[Phone][#secret("phone-number", default: blackout(10))]
  #contact-item[GitHub][#github-link("re-xyr")]
  #contact-item[LinkedIn][#with-secret("linkedin-profile", linkedin-link, default: blackout(14))]
]

#section-title[Education]

#experience([Carnegie Mellon University], position(
  [B.S. in Computer Science (GPA 4.00)],
  from: [Aug 2023],
  to: [Dec 2026],
  location: [Pittsburgh, PA],
))[
  - Relevant coursework: Intro to PL, Parallel Algorithms, Category Theory, Computer Systems, Intro to TCS, Intro to FP, Vector Calculus, Discrete Math, Linear Algebra, Intro to Linguistics
]

#section-title[Work Experience]

#experience([Google], (
  position([Software Engineering Intern (Travel Ads)], from: [May 2025], to: [Aug 2025], location: [Mountain View, CA]),
  position([STEP Intern (Google Learning)], from: [May 2024], to: [Aug 2024], location: [New York, NY]),
))[
  - (2025) Built a large-scale data pipeline for Hotel Ads data analysis, generating insights for 1k+ advertisers
  - (2024) Implemented a new feature in the Google Search math solver and launched a user-facing live experiment
  - Engaged extensively with the Google Search web stack, Ads bidding, and MapReduce data pipelines
]

#experience([MLabs Ltd.], position(
  [Software Consultant (Haskell & Plutus)],
  from: [Oct 2021],
  to: [May 2023],
  location: [London, UK (Remote)],
))[
  - Developed `PSL`, an eDSL in Haskell for writing #link("https://cardano.org/")[Cardano blockchain] transaction specifications
  - Implemented `plutus-extra`, a unit and property testing library for the Plutus smart contract language
]

#experience([Taichi Graphics], position(
  [Intern Compiler Engineer],
  from: [Nov 2021],
  to: [Mar 2023],
  location: [Beijing, China],
))[
  - Proposed and implemented a unified, coherent type system for the #link("https://github.com/taichi-dev/taichi")[Taichi compiler], in place of ad-hoc validation logic
  - Implemented various smaller-scale refactors and compiler passes, such as short-circuiting logical operators
]

#experience([Chinese Academy of Sciences], position(
  [Intern Research Engineer (PLCT Lab)],
  from: [Oct 2020],
  to: [Oct 2021],
  location: [Beijing, China],
))[
  - Core contributor to the open source HoTT proof assistant #link("https://github.com/aya-prover/aya-dev")[Aya Prover] (320 stars on GitHub), mainly on its module and type systems
]

#section-title[Personal Projects]

#project([Cleff], "https://github.com/re-xyr/cleff")[
  - Efficient and versatile effect handlers in Haskell, 2-5x performance gain compared to mainstream libraries
  - Presented at #secret("cleff-venue", default: blackout(27))\; project gained 100+ stars on GitHub
]

#project([Inkclip], "https://github.com/re-xyr/inkclip")[
  - A slim 1.54-inch e-ink wearable accessory with thin bezels, can be attached anywhere for versatile self-expression
  - Custom PCB with STM32F411, Rust (#link("https://embassy.dev/")[embassy]) firmware, and fully client-side web interface written in #link("https://svelte.dev/")[Svelte]
]

#project([Lilynet (AS401736)], "https://daylily.network")[
  - Educational dual-stack (IPv4+v6) network participating in global internet routing, active voting member of ARIN
  - 3 virtual PoPs providing services including authoritative DNS, Tor relays, IPv6 tunneling, and anycast routing
]

#project([Orizuru.app], none)[
  - Federated, anonymous Q&A-based social media platform, built on #link("https://www.w3.org/TR/activitypub/")[ActivityPub], interoperable with #link("https://jointhefediverse.net")[the Fediverse]
  - Full-stack web application developed with #link("https://svelte.dev/docs/kit/introduction")[SvelteKit], #link("https://tailwindcss.com/")[TailwindCSS], #link("https://trpc.io/")[tRPC], #link("https://www.postgresql.org/")[PostgreSQL], and #link("https://fedify.dev/")[Fedify]
]

#section-title[Skills]

#entry[
  - *Programming languages:* Haskell, TypeScript, HTML/CSS, Java, Kotlin, C/C++, Rust, Python, LaTeX
  - *Technologies:* Functional programming, Compiler frontends, Type systems, Full-stack webdev, Data pipelines
  - *Languages:* English: fluent, Mandarin: native
]
