package main

import (
	"fmt"
)

type ReportMapper func(report Report) Report
type ReportPredicate func(report Report) bool
type ReportReducer func(acc Report, cur Report) Report

type Report struct {
	Count int `json:"count"`
}

func (r Report) Combine(other Report) Report {
	return Report{
		Count: r.Count + other.Count,
	}
}

func (r *Report) Add(other Report) {
	r.Count += other.Count
}

func EmptyReport() Report {
	return Report{
		Count: 0,
	}
}

func ToReports(xs []int) (reports []Report) {
	for _, x := range xs {
		reports = append(reports, Report{x})
	}
	return
}

func MapReports(reports []Report, f ReportMapper) (result []Report) {
	for _, report := range reports {
		result = append(result, f(report))
	}
	return
}

func FilterReports(reports []Report, f ReportPredicate) (result []Report) {
	for _, report := range reports {
		if f(report) {
			result = append(result, report)
		}
	}

	return
}

func FoldReports(reports []Report) Report {
	result := EmptyReport()

	for _, report := range reports {
		result = result.Combine(report)
	}

	return result
}

func ReduceReports(reports []Report, initial Report, f ReportReducer) Report {
	if len(reports) == 0 {
		return initial
	}

	result := initial

	for _, report := range reports {
		result = f(result, report)
	}
	return result
}

func main() {
	fmt.Printf("%#v\n", EmptyReport().Combine(Report{10}).Combine(Report{5}))

	reports := ToReports([]int{1, 2, 3, 5, 7, 11, 13, 17})

	fmt.Println(MapReports(reports, func(report Report) Report {
		return Report{2 * report.Count}
	}))

	fmt.Println(FoldReports(reports))
	fmt.Println(ReduceReports(reports, EmptyReport(), func(acc Report, cur Report) Report {
		return acc.Combine(cur)
	}))
}
