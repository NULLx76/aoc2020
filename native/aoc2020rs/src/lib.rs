use rustler::{Encoder, Env, Error, Term};

mod day19;

rustler::rustler_export_nifs! {
  "Elixir.Rust",
  [
      ("day19_part1", 0, day19_part1),
      ("day19_prepare_input", 1, day19_prepare_input),
  ],
  None
}

fn day19_part1<'a>(env: Env<'a>, _: &[Term<'a>]) -> Result<Term<'a>, Error> {
    Ok((day19::part1()).encode(env))
}

fn day19_prepare_input<'a>(env: Env<'a>, args: &[Term<'a>]) -> Result<Term<'a>, Error> {
    let input = args[0].decode()?;

    Ok((day19::prepare_input(input)).encode(env))
}
