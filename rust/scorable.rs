use std::ops::{Add, Mul};

pub struct Score(i64);

impl Add for Score {
    type Output = Self;

    fn add(self, other: Self) -> Self {
        Self(self.0 + other.0)
    }
}

impl Mul for Score {
    type Output = Self;
    
    fn mul(self, other: Self) -> Self {
        Self(self.0 * other.0)
    }
}

pub trait Scorable {
    fn to_score(&self) -> Score;
}

#[derive(Debug)]
pub enum Priority {
    Blocker,
    Ciritial,
    High,
    Medium,
    Low,
    None,
}

impl Scorable for Priority {
    fn to_score(&self) -> Score {
        Score(match self {
            Priority::Blocker => 5,
            Priority::Ciritial => 4,
            Priority::High => 3,
            Priority::Medium => 2,
            Priority::Low => 1,
            Priority::None => 0,
        })
    }
}

#[derive(Debug)]
pub enum Effort {
    Unknown,
    High,
    Medium,
    Low,
}

impl Scorable for Effort {
    fn to_score(&self) -> Score {
        Score(match self {
            Effort::Unknown => 4,
            Effort::High => 3,
            Effort::Medium => 2,
            Effort::Low => 1,
        })
    }
}

#[derive(Debug)]
pub enum Urgency {
    Urgent,
    NotUrgent,
}

impl Scorable for Urgency {
    fn to_score(&self) -> Score {
        Score(match self {
            Urgency::Urgent => 1,
            Urgency::NotUrgent => 0,
        })
    }
}

#[derive(Debug)]
pub enum Importancy {
    Important,
    NotImportant,
}

impl Scorable for Importancy {
    fn to_score(&self) -> Score {
        Score(match self {
            Importancy::Important => 1,
            Importancy::NotImportant => 0,
        })
    }
}

pub fn factor<A: Scorable, B: Scorable>(a: &A, b: &B) -> Score {
    Scorable::to_score(a) * Scorable::to_score(b)
}
